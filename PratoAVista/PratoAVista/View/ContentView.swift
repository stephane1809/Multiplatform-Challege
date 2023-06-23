//
//  ContentView.swift
//  PratoAVista
//
//  Created by Stephane Girão Linhares on 19/06/23.
//

import SwiftUI

struct ContentView: View {

    private var restaurants = RestaurantMockup.getRestaurants()

        var body: some View {
            NavigationView {
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(restaurants) { restaurant in
                            RestaurantCard(restaurant: restaurant)
                        }
                    }
                    .padding(.horizontal)
                }
                .navigationTitle("Restaurantes")
            }.navigationViewStyle(.stack)
                .navigationBarBackButtonHidden()
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
