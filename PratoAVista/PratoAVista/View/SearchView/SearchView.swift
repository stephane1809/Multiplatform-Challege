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

        var body: some View {
            VStack {
                NavigationView {
                    ScrollView {
                        if restaurants.isEmpty {
                            emptyState
                        } else {
                            LazyVStack(spacing: 16) {
                                ForEach(restaurants) { restaurant in
                                    NavigationLink {
                                        RestaurantView(currentRestaurant: restaurant)
                                    } label: {
                                        RestaurantCard(restaurant: restaurant)
                                    }
                                    
                                }
                            }
                            .padding(.horizontal)
                            .navigationTitle("Restaurantes")
                        }
                    }
                    .refreshable {
                        Task {
                            await viewModel.fetch()
                            restaurants = viewModel.restaurants
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
        }else {
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
        VStack {
            RoundedRectangle(cornerRadius: 5)
                .fill(.gray.opacity(0.2))
                .frame(width: .none, height: 130)
                .shadow(color: .gray, radius: 3, x: 4, y: 4)
                .animation(.easeInOut(duration: 1).repeatForever(), value: restaurants.isEmpty)
            
            RoundedRectangle(cornerRadius: 5)
                .fill(.gray.opacity(0.2))
                .frame(width: .none, height: 130)
                .shadow(color: .gray, radius: 3, x: 4, y: 4)
                .animation(.easeInOut(duration: 1).repeatForever(), value: restaurants.isEmpty)
        }
        .padding(.horizontal, 20)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
