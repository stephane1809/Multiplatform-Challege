//
//  CardsFoodView.swift
//  PratoAVista
//
//  Created by Stephane Girão Linhares on 21/06/23.
//

import Foundation
import SwiftUI

struct CardsFoodView: View {

    private var foods = FoodMockup.getFoods()

        var body: some View {
            NavigationView {
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(foods) { food in
                            FoodCard(food: food)
                        }
                    }
                    .padding(.horizontal)
                }
            }.navigationViewStyle(.stack)
                .navigationBarBackButtonHidden()
        }
}
