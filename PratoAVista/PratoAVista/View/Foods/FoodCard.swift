//
//  FoodCard.swift
//  PratoAVista
//
//  Created by Stephane Girão Linhares on 21/06/23.
//

import Foundation
import SwiftUI

struct FoodCard: View {

    var food: FoodModel

    var body: some View {
        HStack(alignment: .top) {

            VStack(alignment: .leading, spacing: 10) {
                Text(food.name)
                    .font(.system(size: 17))
                    .bold()

                ScrollView(.horizontal) {
                    HStack {
                        ForEach(food.tags, id: \.self) { tag in
                            DishTagView(tag: tag)
                        }
                    }
                }

                Text("R$ \(food.price.formatted())")
                    .font(.system(size: 15))

            }
            .foregroundColor(.black)

            Spacer()
            Image(food.image)
                            .resizable()
                            .cornerRadius(10)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 81)
                            .padding(.top, 5)
                            .padding(.bottom, 5)

        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(red: 242/255, green: 242/255, blue: 247/255))
        .cornerRadius(5)
        .shadow(color: .gray, radius: 3, x: 4, y: 4)
    }

}
