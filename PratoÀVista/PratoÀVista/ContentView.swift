//
//  ContentView.swift
//  PratoÀVista
//
//  Created by Stephane Girão Linhares on 16/06/23.
//

import SwiftUI

struct ContentView: View {
    let names = ["Pasto & Pizza", "Josh", "Rhonda", "Ted"]
    @State private var searchText = ""

    var body: some View {
        VStack {
            Text("Localização do usuário")
            NavigationStack {
//                Text("Searching for \(searchText)")
                List {
                                ForEach(searchResults, id: \.self) { name in
                                    NavigationLink {
                                        Text("oi \(name)")
                                    } label: {
                                        Text(name)
                                    }
                                }
                            }
            }
            .searchable(text: $searchText, prompt: "Buscar restaurante")
        }
    }

    var searchResults: [String] {
            if searchText.isEmpty {
                return names
            } else {
                return names.filter { $0.contains(searchText) }
            }
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
