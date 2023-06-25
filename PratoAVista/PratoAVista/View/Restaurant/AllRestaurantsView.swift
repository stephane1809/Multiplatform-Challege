//
//  ContentView.swift
//  PratoAVista
//
//  Created by Stephane Girão Linhares on 19/06/23.
//

import SwiftUI

struct AllRestaurantsView: View {

    @EnvironmentObject private var viewModel: RestaurantsViewModel

        var body: some View {
            NavigationView {
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(viewModel.restaurants) { restaurant in
                            NavigationLink {
                                RestaurantView(currentRestaurant: restaurant)
                            } label: {
                                RestaurantCard(restaurant: restaurant)
                            }
                            
                        }
                    }
                    .padding(.horizontal)
                }
                .refreshable {
                    Task {
                        await viewModel.fetch()
                    }
                }
                .navigationTitle("Restaurantes")
            }
            .navigationBarTitleDisplayMode(.large)
            .navigationViewStyle(.stack)
            .navigationBarBackButtonHidden()
            .onAppear {
                Task {
                    await viewModel.fetch()
                }
            }
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AllRestaurantsView()
            .environmentObject(RestaurantsViewModel())
    }
}
