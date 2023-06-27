//
//  LocationDetailView.swift
//  PratoAVista
//
//  Created by Beatriz Leonel da Silva on 19/06/23.
//

import SwiftUI
import MapKit

struct RestaurantView: View {

    @EnvironmentObject private var viewModel: RestaurantsViewModel
    var currentRestaurant: RestaurantModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                restaurantDescriptionSection
                menuSection
            }
        }
        .overlay {
            if viewModel.selectedImage {
                ZoomImage(currentRestaurant: viewModel.currentRestaurant)
            }
        }
        .ignoresSafeArea(.all, edges: .horizontal)
        .background(.white)
        .transition(.asymmetric(
            insertion: .move(edge: .trailing),
            removal: .move(edge: .trailing)
        ))
        .navigationTitle("")
        .navigationBarBackButtonHidden(viewModel.hiddeBackButton)
        .navigationBarTitleDisplayMode(.inline)
        .navigationViewStyle(.stack)
        .onAppear {
            viewModel.showNextRestaurant(newRestaurant: currentRestaurant)
        }
    }
}

extension RestaurantView {

    private var menuSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Cardápio")
                .font(.title)
                .fontWeight(.semibold)
            NavigationLink {
                if let currentDishes = viewModel.currentRestaurantDishes {
                    MenuView(restaurantRecordName: currentRestaurant.recordName)
                        .environmentObject(MenuViewModel(
                            restaurant: viewModel.currentRestaurant,
                            dishes: currentDishes))
                }
            } label: {
                MenuCard(menu: MenuModel(name: viewModel.currentRestaurant.name ?? "",
                                         image: "pastoLogo"))
            }
        }
        .padding()
    }

    private var restaurantDescriptionSection: some View {
        VStack {
            HeaderRestaurantView(currentRestaurant: currentRestaurant)

            VStack(alignment: .leading, spacing: 9) {
                titleSection
                descriptionSection
                tagsSection
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .cornerRadius(5)
        }
        .background(.white)
        .cornerRadius(8)
        .shadow(color: .black.opacity(0.25),
                radius: 4, x: 0, y: 4)
    }

    private var titleSection: some View {
        Text(currentRestaurant.name ?? "Restaurante")
            .font(.title)
            .fontWeight(.semibold)
    }

    private var descriptionSection: some View {
        VStack(alignment: .leading, spacing: 2) {
            if let location = currentRestaurant.location {
                Text(location + ".")
                    .font(.subheadline)
            }
            if let operation = currentRestaurant.operation {
                Text(operation)
                    .font(.subheadline)
            }
            if let telephone = currentRestaurant.whatsapp {
                Text("Telefone: " +  telephone)
                    .font(.subheadline)
            }

        }
    }

    private var tagsSection: some View {
        HStack(alignment: .firstTextBaseline, spacing: 6) {
            if currentRestaurant.airConditioned {
                RestaurantTagView(tag: .withAirConditioning)
            }
            if currentRestaurant.petFrendly {
                RestaurantTagView(tag: .petFrendly)
            }
            if currentRestaurant.wifi {
                RestaurantTagView(tag: .freeWifi)
            }
        }
    }
}

struct LocationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantView(currentRestaurant: RestaurantModel())
            .environmentObject(RestaurantsViewModel())
    }
}
