//
//  LocationsView.swift
//  PratoAVista
//
//  Created by Beatriz Leonel da Silva on 19/06/23.
//

import SwiftUI
import MapKit

struct IpadConfigurations {
    static let maxWidthForIpad: CGFloat = 700
}

struct LocationsView: View {
    
    @EnvironmentObject private var viewModel: LocationsViewModel
    
    var body: some View {
        ZStack {
            mapLayer
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                Spacer()
                locationPreview
            }
            
            
        }
        .sheet(item: $viewModel.sheetLocation) { location in
            LocationDetailView(currentLocation: location)
        }
        .overlay {
            if viewModel.selectedImage {
                ZoomImage(currentLocation: viewModel.mapLocation)
            }
        }
    }
}

extension LocationsView {
    
    private var header: some View {
        VStack {
            Text(viewModel.mapLocation.name + ", " + viewModel.mapLocation.cityName)
                .font(.title2)
                .fontWeight(.black)
                .foregroundColor(.primary)
                .frame(height: 65)
                .frame(maxWidth: .infinity)
                .animation(.none, value: viewModel.mapLocation)
                .overlay(alignment: .leading) {
                    Image(systemName: "arrow.down")
                        .font(.headline)
                        .foregroundColor(.primary)
                        .padding()
                        .rotationEffect(Angle(degrees: viewModel.showLocationsList ? 180 : 0))
                }
            if viewModel.showLocationsList {
                LocationsListView()
            }
        }
        .background(.thickMaterial)
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y:15)
        .onTapGesture {
            viewModel.toggleLocationsList()
        }
    }
    
    private var mapLayer: some View {
        Map(coordinateRegion: $viewModel.mapRegion,
            annotationItems: viewModel.locations,
            annotationContent: { location in
            MapAnnotation(coordinate: location.coordinates) {
                LocationMapAnnotationView()
                    .scaleEffect(viewModel.mapLocation == location ? 1.1 : 0.7)
                    .shadow(radius: 10)
                    .onTapGesture {
                        viewModel.showNextLocation(location: location)
                    }
            }
            
        })
    }
    
    private var locationPreview: some View {
        ZStack {
            ForEach(viewModel.locations) { location in
                if viewModel.mapLocation == location {
                    LocationPreviewView(location: location)
                        .shadow(color: .black.opacity(0.3), radius: 10)
                        .padding()
                        .frame(maxWidth: IpadConfigurations.maxWidthForIpad)
                        .frame(maxWidth: .infinity)
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing),
                            removal: .move(edge: .leading)))
                }
            }
        }
    }
    
}

struct LocationsView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsView()
            .environmentObject(LocationsViewModel())
    }
}

