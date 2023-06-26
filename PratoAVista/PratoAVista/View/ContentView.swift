//
//  ContentView.swift
//  PratoAVista
//
//  Created by Stephane Girão Linhares on 19/06/23.
//

import SwiftUI

struct ContentView: View {
    let restaurantManager = RestaurantManager()
    let dishManager = DishManager()
    let recordName = "7603F070-33F1-81AB-7462-E242F1B20A93"
    @State var restaurants: [JSONRestaurant] = []
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
                    restaurants = []
                    restaurants = restaurantManager.getRestaurantsFromDevice()
//                    restaurants.append(restaurant)
                    for restaurant in restaurants {
                        print(restaurant.fantasyName)
                        print(restaurant.dishes.count)
                        for dish in restaurant.dishes {
                            print(dish.dishName)
                            for alergenic in dish.alergenics {
                                print(alergenic)
                            }
                        }
                        print("------")
                    }

                }
            }

            List {
                ForEach(restaurants) { restaurant in
                    VStack {
                        Text(restaurant.recordName)
                        Text(restaurant.fantasyName!)
                        List {
                            ForEach(restaurant.dishes) { dish in
                                Text(dish.dishName!)
//                                List {
//                                    ForEach(dish.alergenics, id: \.self) { alergenic in
//                                        Text(alergenic)
//                                    }
//                                }
                            }
                        }
                    }
                }
            }
        }
        .padding()
        .onAppear {//            let dish = CloudKitDishRepository().getDishBy(recordName: "210CC0C1-E850-6C27-8B27-EB2485A71BE8")

//            print(dish)
            Task {
//                let dish = await dishManager.getDishBy(recordName: "210CC0C1-E850-6C27-8B27-EB2485A71BE8")
//
//                for alergenic in dish.alergenics {
//                    print(alergenic)
//                }
//
//                for ingredient in dish.ingredients {
//                    print(ingredient)
//                }

                let restaurant = await restaurantManager.getRestaurantFromCloudKit(recordName: recordName)
                print(restaurant.fantasyName)
            }
        }
    }
}

