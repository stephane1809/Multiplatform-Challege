//
//  LocationsListView.swift
//  PratoAVista
//
//  Created by Beatriz Leonel da Silva on 19/06/23.
//

import SwiftUI

struct LocationsListView: View {
    
    @EnvironmentObject private var viewModel: LocationsViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.locations) { location in
                listRowView(location)
                    .padding(.vertical, 4)
                    .listRowBackground(Color.clear)
                    .onTapGesture {
                        viewModel.showNextLocation(location: location)
                    }
            }
        }
        .listStyle(.plain)
    }
}

extension LocationsListView {
    private func listRowView(_ location: Location) -> some View {
        HStack {
            if let imageName = location.imageNames.first {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 45, height: 45)
                    .cornerRadius(10)
            }
            
            VStack(alignment: .leading) {
                Text(location.name)
                    .font(.headline)
                Text(location.cityName)
                    .font(.subheadline)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct LocationsListView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsListView()
            .environmentObject(LocationsViewModel())
    }
}
