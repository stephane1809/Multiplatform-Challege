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
    
    @EnvironmentObject private var viewModel: RestaurantsViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                mapLayer
                    .ignoresSafeArea(.all, edges: .top)
                
                VStack(spacing: 0) {
                    Spacer()
                    locationPreview
                }
            }
            .overlay {
                if viewModel.selectedImage {
                    ZoomImage(currentRestaurant: viewModel.currentRestaurant)
                }
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .navigationViewStyle(.stack)
        .onAppear {
            Task {
                await viewModel.fetch()
            }
        }
        .alert(viewModel.localError?.localizedDescription ?? "Erro!",
               isPresented: .constant(viewModel.localError != nil)) {
            Button("OK") {
                viewModel.finishError()
            }
        } message: {
            Text(viewModel.localError?.recoverySuggestion ?? "Tente novamente.")
        }
    }
}

extension LocationsView {
    
    private var mapLayer: some View {
        Map(coordinateRegion: $viewModel.mapRegion,
            annotationItems: viewModel.restaurants,
            annotationContent: { restaurant in
            MapAnnotation(coordinate: restaurant.coordinate) {
                LocationMapAnnotationView()
                    .scaleEffect(viewModel.currentRestaurant == restaurant ? 1.1 : 0.7)
                    .shadow(radius: 10)
                    .onTapGesture {
                        viewModel.showNextRestaurant(newRestaurant: restaurant)
                    }
            }
            
        })
    }
    
    private var locationPreview: some View {
        ZStack {
            ForEach(viewModel.restaurants) { restaurant in
                if viewModel.currentRestaurant == restaurant {
                    LocationPreviewView(currentRestaurant: restaurant)
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
            .environmentObject(RestaurantsViewModel())
    }
}

