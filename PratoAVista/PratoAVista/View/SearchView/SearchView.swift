//
//  SearchView.swift
//  PratoAVista
//
//  Created by Stephane Girão Linhares on 22/06/23.
//

import Foundation
import SwiftUI
import MapKit

struct SearchView: View {

    @EnvironmentObject private var viewModel: RestaurantsViewModel
    @State var searchText = ""
    @State private var restaurants: [RestaurantModel] = []
    @State var title: String = "Restaurantes"

        var body: some View {
            VStack {
                NavigationView {
                    if restaurants.isEmpty {
                        emptyState
                            .navigationTitle(title)

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
