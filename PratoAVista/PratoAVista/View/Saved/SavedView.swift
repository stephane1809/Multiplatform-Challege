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

        var body: some View {
            NavigationView {
                ScrollView {
                    LazyVStack(spacing: 16) {
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
