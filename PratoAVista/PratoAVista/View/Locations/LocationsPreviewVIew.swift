//
//  LocationsPreviewVIew.swift
//  PratoAVista
//
//  Created by Beatriz Leonel da Silva on 19/06/23.
//

import SwiftUI
import CloudKit

struct LocationPreviewView: View {
    
    @EnvironmentObject private var viewModel: RestaurantsViewModel
    let currentRestaurant: RestaurantModel
    
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 16) {
                if let ckAsset =  currentRestaurant.picture {
                    if let uiImage = convertToUIImage(ckAsset: ckAsset){
                        imageSection(uiImage: uiImage)
                    }
                } else {
                    emptyImageSection
                }
                tittleSection
            }
            VStack(spacing: 10) {
                learnMoreButton
                nextButton
            }
            .offset(y: 32.5)
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
    
    private func imageSection(uiImage: UIImage) -> some View {
        return (
            ZStack {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .cornerRadius(10)
                    .allowsHitTesting(true)
                    .onTapGesture {
                        viewModel.showSelectedImage()
                    }
            }
            .padding(6)
            .background(Color.white)
            .cornerRadius(10)
        )
    }
    
    private var emptyImageSection: some View {
        ZStack {
            Image(systemName: "fork.knife.circle.fill")
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
                .cornerRadius(10)
                .allowsHitTesting(true)
                .onTapGesture {
                    viewModel.showSelectedImage()
                }
        }
        .padding(6)
        .background(Color.white)
        .cornerRadius(10)
    }
    
    private var tittleSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(currentRestaurant.name ?? "")
                .font(.title2)
                .fontWeight(.bold)
            Text(currentRestaurant.location ?? "")
                .font(.subheadline)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var learnMoreButton: some View {
        NavigationLink {
            RestaurantView(currentRestaurant: viewModel.currentRestaurant)
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
            LocationPreviewView(currentRestaurant: RestaurantModel())
                .environmentObject(RestaurantsViewModel())
                .padding()
        }
        .ignoresSafeArea()
    }
}

