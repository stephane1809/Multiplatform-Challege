//
//  SearchView.swift
//  PratoAVista
//
//  Created by Stephane Girão Linhares on 22/06/23.
//

import Foundation
import SwiftUI
import MapKit
import Combine
import CoreLocation

struct SearchView: View {

    @StateObject var deviceLocationService = DeviceLocationService.shared

    @State var tokens: Set<AnyCancellable> = []
    @State var coordinates: (lat: Double, lon: Double) = (0, 0)

    @State var address: String = "Nenhum endereço encontrado"
    @EnvironmentObject private var viewModel: RestaurantsViewModel
    @State var searchText = ""
    @State private var restaurants: [RestaurantModel] = []
    @State var title: String = "Restaurantes"

    var body: some View {

        NavigationView {
            VStack(alignment: .leading) {
                HStack {
                    Label(address.capitalized, systemImage: "location")
                        .font(.system(size: 19))
                }
                .padding([.leading], 20)
                Spacer()
                if restaurants.isEmpty {
                    emptyState
                        .navigationTitle(title)
                    Spacer()

                } else {
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(restaurants) { restaurant in
                                NavigationLink {
                                    RestaurantView(currentRestaurant: restaurant)
                                } label: {
                                    RestaurantCard(restaurant: restaurant)
                                }
                            }
                        }
                        .navigationTitle(title)

                        .padding(.horizontal)
                    }
                    .refreshable {
                        Task {
                            await viewModel.fetch()
                            restaurants = viewModel.restaurants
                        }
                    }
                }
            }
            .onAppear {
                observeCoordinateUpdates()
                observeDeniedLocationAccess()
                deviceLocationService.requestLocationUpdates()
            }
            .onChange(of: CLLocation(latitude: coordinates.lat, longitude: coordinates.lon)) { location in
                Task {
                    let geocoder = CLGeocoder()
                    let placemarks = try await geocoder.reverseGeocodeLocation(location)
                    self.address = placemarks.first?.thoroughfare ?? ""
                }
            }

        }
        .searchable(text: $searchText)
        .navigationViewStyle(.stack)
        .navigationBarBackButtonHidden()
        .onChange(of: searchText, perform: { _ in
            filterRecipes()
        })
        .onAppear {
            Task {
                await viewModel.fetch()
                restaurants = viewModel.restaurants
            }
        }
        .alert(viewModel.localError?.localizedDescription ?? "Erro!",
               isPresented: .constant(viewModel.localError != nil)) {
            Button("OK") {
                viewModel.finishError()
            }
        } message: {
            Text(viewModel.localError?.recoverySuggestion ?? "Tente novamente.")
        }

    }

    func filterRecipes() {
        if searchText.isEmpty {
            restaurants = viewModel.restaurants
        } else {
            if viewModel.restaurants.filter({$0.name!.localizedCaseInsensitiveContains(searchText)}).isEmpty {
                restaurants = viewModel.restaurants.filter({$0.location!.localizedCaseInsensitiveContains(searchText)})
            } else {
                restaurants = viewModel.restaurants.filter({$0.name!.localizedCaseInsensitiveContains(searchText)})
            }
        }
    }

    func observeCoordinateUpdates() {
        deviceLocationService.coordinatesPublisher
            .receive(on: DispatchQueue.main)
            .sink { completion in
                print("Handle \(completion) for error and finished subscription.")
            } receiveValue: { coordinates in
                self.coordinates = (coordinates.latitude, coordinates.longitude)

            }
            .store(in: &tokens)
    }

    func observeDeniedLocationAccess() {
        deviceLocationService.deniedLocationAccessPublisher
            .receive(on: DispatchQueue.main)
            .sink {
                print("Handle access denied event, possibly with an alert.")
            }
            .store(in: &tokens)
    }
}

extension SearchView {
    private var emptyState: some View {
        VStack(alignment: .center, spacing: 15) {
            Image(systemName: "x.circle")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.gray)
            Text("Nenhum restaurante encontrado")
                .font(.callout)
                .fontWeight(.semibold)
                .foregroundColor(.gray)
        }
        .padding(.horizontal, 20)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
