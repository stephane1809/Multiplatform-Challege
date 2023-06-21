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

            VStack(alignment: .leading, spacing: 5) {
                Text(restaurant.name)
                    .font(.system(size: 17))
                    .bold()

                Text(restaurant.location)
                    .font(.system(size: 13))

                Label("\(restaurant.distance.formatted()) km de distância", systemImage: "location.north.fill")
                    .font(.system(size: 13))

            }
            .foregroundColor(.black)
            Spacer()
            Image(restaurant.image)
                            .resizable()
                            .cornerRadius(10)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 81)
                            .padding(.top, 10)
                            .padding(.bottom, 10)

        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(red: 242/255, green: 242/255, blue: 247/255))
        .cornerRadius(5)
        .shadow(color: .gray, radius: 3, x: 4, y: 4)
    }
}
