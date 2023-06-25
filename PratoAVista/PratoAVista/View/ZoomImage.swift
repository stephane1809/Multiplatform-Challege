//
//  ZoomImage.swift
//  PratoAVista
//
//  Created by Beatriz Leonel da Silva on 20/06/23.
//

import SwiftUI

struct ZoomImage: View {
    
    let currentRestaurant: RestaurantModel
    @State var scale = 0.0
    @EnvironmentObject var viewModel: RestaurantsViewModel
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.7)
                .ignoresSafeArea()
            
            VStack{
                if let ckAsset = currentRestaurant.picture {
                    if let uiImage = convertToUIImage(ckAsset: ckAsset) {
                        imageSection(uiImage: uiImage)
                    }
                }
            }
        }
        .overlay(closeButton, alignment: .topTrailing)
        .onAppear {
            withAnimation(.easeInOut(duration: 0.25)) {
                scale = 1.0
            }
        }
    }
}

extension ZoomImage {

    private var closeButton: some View {
        Button {
            withAnimation(.easeInOut(duration: 0.15)) {
                scale = 0.0
                viewModel.hideSelectedImage()
            }
        } label: {
            Image(systemName: "xmark")
                .resizable()
                .scaledToFit()
                .frame(width: 25)
                .padding(.horizontal, 20)
                .padding(.top, 10)
                .foregroundColor(.white)
        }
    }
    
    private func imageSection(uiImage: UIImage) -> some View {
        return(
            TabView {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .clipped()
            }
                .frame(height: UIDevice.current.userInterfaceIdiom == .pad ? nil : 500)
                .padding([.vertical], 100)
                .scaleEffect(scale)
                .tabViewStyle(.page)
        )
    }
}

struct ZoomImage_Previews: PreviewProvider {
    static var previews: some View {
        ZoomImage(currentRestaurant: RestaurantModel())
    }
}
