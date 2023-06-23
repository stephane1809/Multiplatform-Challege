//
//  LocationDetailView.swift
//  PratoAVista
//
//  Created by Beatriz Leonel da Silva on 19/06/23.
//

import SwiftUI
import MapKit

struct RestaurantView: View {
    
    @EnvironmentObject private var viewModel: LocationsViewModel
    let currentLocation: Location
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15){
                restaurantDescriptionSection
                menuSection
            }
        }
        .ignoresSafeArea()
        .background(.white)
        .overlay(backButton, alignment: .topLeading)
        .transition(.asymmetric(
            insertion: .move(edge: .trailing),
            removal: .move(edge: .trailing)
        ))
    }
}

extension RestaurantView {
    
    private var menuSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Cardápio")
                .font(.title)
                .fontWeight(.semibold)
            // MARK: Add menu card here!
        }
        .padding()
    }
    
    private var restaurantDescriptionSection: some View {
        VStack {
            HeaderRestaurantView(currentLocation: currentLocation)
            
            VStack(alignment: .leading, spacing: 9){
                titleSection
                descriptionSection
                tagsSection
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .cornerRadius(5)
            
        }
        .background(.white)
        .cornerRadius(8)
        .shadow(color: .black.opacity(0.25),
                radius: 4, x:0, y: 4)
    }
    
    private var titleSection: some View {
        Text(currentLocation.name)
            .font(.title)
            .fontWeight(.semibold)
    }
    
    private var descriptionSection: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(currentLocation.address)
                .font(.subheadline)
            Text("Horário de funcionamento: " + currentLocation.operation)
                .font(.subheadline)
            Text("Telefone: (85) 3257-1276")
                .font(.subheadline)
            
        }
    }
    
    private var tagsSection: some View {
        HStack (alignment: .firstTextBaseline, spacing: 6) {
            RestaurantTagView(tag: .freeWifi)
            RestaurantTagView(tag: .petFrendly)
            RestaurantTagView(tag: .withAirConditioning)
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
            withAnimation{
                viewModel.sheetLocation = nil
            }
        } label: {
            Image(systemName: "chevron.backward")
                .resizable()
                .scaledToFit()
                .frame(
                    width: UIDevice.current.userInterfaceIdiom == .pad ? 22 : 18,
                    height: UIDevice.current.userInterfaceIdiom == .pad ? 28 : 22
                )
                .padding()
                .foregroundColor(.primary)
        }
    }
}

struct LocationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantView(currentLocation: LocationsDataService.locations.first!)
            .environmentObject(LocationsViewModel())
    }
}
