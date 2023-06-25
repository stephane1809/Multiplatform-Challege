//
//  ContentView.swift
//  PratoAVista
//
//  Created by Stephane Girão Linhares on 19/06/23.
//

import SwiftUI

struct ContentView: View {
    let restaurantManager = RestaurantManager()
    let recordName = "7603F070-33F1-81AB-7462-E242F1B20A93"
    @State var restaurants: [Restaurant] = []
    var body: some View {
        VStack {
            HStack {
                Button("save") {
                    Task {
                        await restaurantManager.saveRestaurant(recordName: recordName)
                    }
                }
                Spacer()

                Button("delete") {
                    restaurantManager.removeFromSaved(recordName: recordName)
                }
                
                Spacer()

                Button("refresh") {
                    let restaurant = restaurantManager.getRestaurant(recordName: recordName)
                    restaurants.append(restaurant)
                }
            }

            List {
                ForEach(restaurants) { restaurant in
                    VStack {
                        Text(restaurant.recordName)
                        Text(restaurant.fantasyName!)
                    }
                }
            }
        }
        .padding()
    }
}

