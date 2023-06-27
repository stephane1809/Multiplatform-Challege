//
//  SavedView.swift
//  PratoAVista
//
//  Created by Stephane Girão Linhares on 24/06/23.
//

import Foundation
import SwiftUI

struct SavedView: View {

//    private var menus = MenuMockup.getMenu()
    private var menus: [MenuModel] = []

        var body: some View {
            NavigationView {
                if menus.isEmpty {
                    emptyState

                } else {
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
            }
            .navigationViewStyle(.stack)
            .navigationBarBackButtonHidden()
        }
}

extension SavedView {
    private var emptyState: some View {
        VStack(alignment: .center, spacing: 15) {
            Image(systemName: "x.circle")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.gray)
            Text("Nenhum cardápio salvo.")
                .font(.callout)
                .fontWeight(.semibold)
                .foregroundColor(.gray)
        }
        .padding(.horizontal, 20)
    }
}
