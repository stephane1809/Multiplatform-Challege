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
                    .environmentObject(RestaurantsViewModel())
                    .tabItem {
                        Label("Pesquisar", systemImage: "magnifyingglass")
                    }
                SavedView()
                    .tabItem {
                        Label("Salvos", systemImage: "bookmark")
                    }
                LocationsView()
                    .environmentObject(RestaurantsViewModel())
                    .tabItem {
                        Label("mapas", systemImage: "map")
                    }
            }
        }
    }
}
