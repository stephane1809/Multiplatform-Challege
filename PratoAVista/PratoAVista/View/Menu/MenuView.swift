//
//  CardsFoodView.swift
//  PratoAVista
//
//  Created by Stephane Girão Linhares on 21/06/23.
//

import Foundation
import SwiftUI

struct MenuView: View {

    private var foods = FoodMockup.getFoods()

        var body: some View {
            NavigationView {
               dishList
            }
            .navigationTitle("Cardápio")
            .navigationViewStyle(.stack)
            .navigationBarTitleDisplayMode(.inline)
        }
}

extension MenuView {

    private var dishList: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(foods) { food in
                    FoodCard(food: food)
                }
            }
            .padding(.horizontal)
        }
    }

}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
            .previewDevice(.init(rawValue: "iPhone 14"))
            .previewDisplayName("iPhone")

        MenuView()
            .previewDevice(.init(rawValue: "iPad Pro (12.9-inch) (6th generation)"))
            .previewDisplayName("iPad")
    }
}
