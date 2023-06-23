//
//  LocationsPreviewVIew.swift
//  PratoAVista
//
//  Created by Beatriz Leonel da Silva on 19/06/23.
//

import SwiftUI

struct LocationPreviewView: View {
    
    @EnvironmentObject private var viewModel: LocationsViewModel
    let location: Location
    
    var body: some View {
        HStack(alignment: .bottom) {
            VStack(alignment: .leading, spacing: 16) {
                imageSection
                tittleSection
            }
            VStack(spacing: 10) {
                learnMoreButton
                nextButton
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.ultraThinMaterial)
                .offset(y: 65)
        )
        .cornerRadius(10)
        .navigationTitle("")
    }
}

extension LocationPreviewView {
    
    private var imageSection: some View {
        ZStack {
            if let imageName = location.imageNames.first {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .cornerRadius(10)
                    .allowsHitTesting(true)
                    .onTapGesture {
                        viewModel.showSelectedImage()
                    }
            }
        }
        .padding(6)
        .background(Color.white)
        .cornerRadius(10)
    }
    
    private var tittleSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(location.name)
                .font(.title2)
                .fontWeight(.bold)
            Text(location.cityName)
                .font(.subheadline)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var learnMoreButton: some View {
        NavigationLink {
            RestaurantView(currentLocation: viewModel.mapLocation)
        } label: {
            Text("Ler mais")
                .foregroundColor(.white)
                .font(.headline)
                .frame(width: 150, height: 50)
                .background(Color.blue)
                .cornerRadius(8)
        }
    }
    
    private var nextButton: some View {
        Button {
            viewModel.nextButtonPressed()
        } label: {
            Text("Próximo")
                .font(.headline)
                .frame(width: 125, height: 35)
        }
        .buttonStyle(.bordered)
    }
}

struct LocationPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.cyan
            LocationPreviewView(location: LocationsDataService.locations.first!)
                .environmentObject(LocationsViewModel())
                .padding()
        }
        .ignoresSafeArea()
    }
}

