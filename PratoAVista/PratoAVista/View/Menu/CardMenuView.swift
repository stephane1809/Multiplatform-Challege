//
//  CardMenuView.swift
//  PratoAVista
//
//  Created by Stephane Girão Linhares on 21/06/23.
//

import Foundation
import SwiftUI

struct CardsMenuView: View {

    private var menus = MenuMockup.getMenu()

        var body: some View {
            NavigationView {
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(menus) { menu in
                            MenuCard(menu: menu)
                        }
                    }
                    .padding(.horizontal)
                }
            }.navigationViewStyle(.stack)
                .navigationBarBackButtonHidden()
        }
}
