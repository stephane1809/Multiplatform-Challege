//
//  SavedView.swift
//  PratoAVista
//
//  Created by Stephane Girão Linhares on 24/06/23.
//

import Foundation
import SwiftUI

struct SavedView: View {

    private var menus = MenuMockup.getMenu()
    @State var restaurants = RestaurantManager().getRestaurantsFromDevice()

        var body: some View {
            NavigationView {
                ScrollView {
                    LazyVStack(spacing: 16) {
//                        ForEach(restaurants) { restaurant in
//                            NavigationLink {
//                                if let currentDishes = viewModel.currentRestaurantDishes {
//                                    MenuView(restaurantRecordName: currentRestaurant.recordName)
//                                        .environmentObject(MenuViewModel(
//                                            restaurant: viewModel.currentRestaurant,
//                                            dishes: currentDishes))
//                                }
//                            } label: {
//                                MenuCard(menu: MenuModel(name: viewModel.currentRestaurant.name ?? "",
//                                                         image: "pastoLogo"))
//                            }
//                        }
                        ForEach(menus) { menu in
                            MenuCard(menu: menu)
                        }
                        .navigationTitle("Salvos")
                    }
                    .padding(.horizontal)
                }
            }
            .navigationViewStyle(.stack)
            .navigationBarBackButtonHidden()
        }
}
