//
//  ContentView.swift
//  PratoAVista
//
//  Created by Stephane Girão Linhares on 19/06/23.
//

import SwiftUI

struct ContentView: View {

    @State var searchText = ""
    @State private var restaurants = RestaurantMockup.getRestaurants()

        var body: some View {
            NavigationView {
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
            .navigationViewStyle(.stack)
            .navigationBarBackButtonHidden()
            .onChange(of: searchText, perform: { _ in
                filterRecipes()
            })
        }

    func filterRecipes() {
        if searchText.isEmpty {

            restaurants = RestaurantMockup.getRestaurants()
        }else {
            restaurants = RestaurantMockup.getRestaurants().filter({$0.name.localizedCaseInsensitiveContains(searchText)})
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
