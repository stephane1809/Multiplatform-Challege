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
                CardsMenuView()
                    .tabItem {
                        Label("Salvos", systemImage: "bookmark")
                    }
                CardsFoodView()
                    .tabItem {
                        Label("Pesquisar", systemImage: "magnifyingglass")
                    }
                LocationsView()
                    .tabItem {
                        Label("mapas", systemImage: "map")
                    }
            }

//                .environmentObject(LocationsViewModel())
//            ContentView()

        }
    }
}
