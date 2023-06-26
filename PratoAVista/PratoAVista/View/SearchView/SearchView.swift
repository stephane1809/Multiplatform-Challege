//
//  SearchView.swift
//  PratoAVista
//
//  Created by Stephane Girão Linhares on 22/06/23.
//

import Foundation
import Combine
import SwiftUI
import CoreLocation
import MapKit

struct SearchView: View {

    @State var address: String = ""
    @State var tokens: Set<AnyCancellable> = []
    @State var coordinates: (lat: Double, lon: Double) = (0, 0)
    @StateObject var deviceLocationService = DeviceLocationService.shared
    @State var searchText = ""
    @State private var restaurants = RestaurantMockup.getRestaurants()

        var body: some View {

                NavigationView {
                    VStack {
                        HStack {
                            Label(address.capitalized, systemImage: "location")
                                .font(.system(size: 19))
                            Spacer()
                        }
                        .padding([.leading], 20)

                        ScrollView {
                            LazyVStack(spacing: 16) {
                                ForEach(restaurants) { restaurant in
                                    RestaurantCard(restaurant: restaurant)
                                }
                            }

                            .padding(.horizontal)
                            .navigationTitle("Restaurantes")
                        }
                    }
                    .searchable(text: $searchText)
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

                .navigationViewStyle(.stack)
                .navigationBarBackButtonHidden()
                .onChange(of: searchText, perform: { _ in
                    filterRecipes()
                })
        }

    func filterRecipes() {
        if searchText.isEmpty {

            restaurants = RestaurantMockup.getRestaurants()
        } else {
            restaurants = RestaurantMockup.getRestaurants().filter({$0.name.localizedCaseInsensitiveContains(searchText)})
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

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
