//
//  RestaurantCard.swift
//  PratoAVista
//
//  Created by Stephane Girão Linhares on 21/06/23.
//

import Foundation
import SwiftUI

struct RestaurantCard: View {

    var restaurant: RestaurantModel

    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 10) {
                Text(restaurant.name ?? "Restaurante")
                    .font(.system(size: 17))
                    .bold()


                Text(restaurant.location ?? "")
                    .font(.system(size: 13))

                Label("200 km de distância", systemImage: "location.north.fill")
                    .font(.system(size: 13))

                if restaurant.wifi || restaurant.airConditioned || restaurant.petFrendly {
                    ScrollView(.horizontal) {
                        HStack {
                            if restaurant.wifi {
                                RestaurantTagView(tag: .freeWifi)
                            }
                            if restaurant.airConditioned {
                                RestaurantTagView(tag: .withAirConditioning)
                            }
                            if restaurant.petFrendly {
                                RestaurantTagView(tag: .petFrendly)
                            }
                        }
                    }
                }

            }
            .foregroundColor(.black)
            Spacer()

            if let ckAsset = restaurant.picture {
                if let uiImage = convertToUIImage(ckAsset: ckAsset) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .cornerRadius(10)
                }
            }

        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(red: 242/255, green: 242/255, blue: 247/255))
        .cornerRadius(5)
        .shadow(color: .gray, radius: 3, x: 4, y: 4)
    }
}
