//
//  LocationDetailView.swift
//  PratoAVista
//
//  Created by Beatriz Leonel da Silva on 19/06/23.
//

import SwiftUI
import MapKit

struct LocationDetailView: View {
    
    @EnvironmentObject private var viewModel: LocationsViewModel
    let currentLocation: Location
    
    var body: some View {
        ScrollView {
            VStack {
                
                imageSection
                    .shadow(color: .black.opacity(0.3),
                            radius: 20, x:0, y: 10)
                VStack(alignment: .leading, spacing: 6){
                    titleSection
                    Divider()
                    descriptionSection
                    Divider()
                    mapLayer
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                
            }
        }
        .ignoresSafeArea()
        .background(.ultraThinMaterial)
        .overlay(backButton, alignment: .topLeading)
    }
}

extension LocationDetailView {
    private var imageSection: some View {
        TabView {
            ForEach(currentLocation.imageNames,
                    id: \.self) { imageName in
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIDevice.current.userInterfaceIdiom == .pad ? nil : UIScreen.main.bounds.width)
                    .clipped()
            }
        }
        .frame(height: 500)
        .tabViewStyle(.page)
    }
    
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(currentLocation.name)
                .font(.largeTitle)
                .fontWeight(.semibold)
            Text(currentLocation.cityName)
                .font(.title3)
                .foregroundColor(.secondary)
        }
    }
    
    private var descriptionSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("\(currentLocation.operation)")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Text("\(currentLocation.address)")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            
            if let url = URL(string: currentLocation.link) {
                Link("Ver mais no site", destination: url)
                    .font(.headline)
                    .tint(.blue)
            }
        }
    }
    
    private var mapLayer: some View {
        Map(coordinateRegion: .constant(MKCoordinateRegion(
            center: currentLocation.coordinates,
            span: viewModel.mapSpan)),
            annotationItems: [currentLocation]) { location in
            MapAnnotation(coordinate: location.coordinates) {
                LocationMapAnnotationView()
            }
        }
            .aspectRatio(2, contentMode: .fit)
            .cornerRadius(20)
            .allowsHitTesting(false)
    }
    
    private var backButton: some View {
        Button {
            viewModel.sheetLocation = nil
        } label: {
            Image(systemName: "xmark")
                .font(.headline)
                .padding(16)
                .foregroundColor(.primary)
                .background(.thickMaterial)
                .cornerRadius(30)
                .shadow(radius: 4)
                .padding()
        }
    }
}

struct LocationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LocationDetailView(currentLocation: LocationsDataService.locations.first!)
            .environmentObject(LocationsViewModel())
    }
}
