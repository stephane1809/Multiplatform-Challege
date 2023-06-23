//
//  SearchView.swift
//  PratoAVista
//
//  Created by Stephane Girão Linhares on 22/06/23.
//

import Foundation
import SwiftUI

struct SearchView: View {

    private var restaurants = RestaurantMockup.getRestaurants()

    var body: some View {
        VStack {
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
            .navigationViewStyle(.stack)
            .navigationBarBackButtonHidden()
        }

    }
}
