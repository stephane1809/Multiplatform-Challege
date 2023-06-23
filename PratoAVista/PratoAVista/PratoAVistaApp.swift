//
//  PratoAVistaApp.swift
//  PratoAVista
//
//  Created by Stephane Girão Linhares on 19/06/23.
//

import SwiftUI

@main
struct PratoAVistaApp: App {
    var body: some Scene {
        WindowGroup {
            TabView{
                SearchView()
                    .tabItem {
                        Label("Pesquisar", systemImage: "magnifyingglass")
                    }
                CardsMenuView()
                    .tabItem {
                        Label("Salvos", systemImage: "bookmark")
                    }
                LocationsView()
                    .tabItem {
                        Label("mapas", systemImage: "map")
                    }
            }
        }
    }
}
