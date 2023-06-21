//
//  ZoomImage.swift
//  PratoAVista
//
//  Created by Beatriz Leonel da Silva on 20/06/23.
//

import SwiftUI

struct ZoomImage: View {
    
    let currentLocation: Location
    @State var scale = 0.0
    @EnvironmentObject var viewModel: LocationsViewModel
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.7)
                .ignoresSafeArea()
            
            VStack{
                imageSection
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
            withAnimation(.easeInOut(duration: 0.1)) {
                scale = 0.0
                viewModel.hideSelectedImage()
            }
        } label: {
            Image(systemName: "xmark")
                .resizable()
                .scaledToFit()
                .frame(width: 25)
                .padding()
                .foregroundColor(.white)
        }
    }
    
    private var imageSection: some View {
        TabView {
            ForEach(currentLocation.imageNames,
                    id: \.self) { imageName in
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .clipped()
            }
        }
        .frame(height: UIDevice.current.userInterfaceIdiom == .pad ? nil : 500)
        .padding([.vertical], 100)
        .scaleEffect(scale)
        .tabViewStyle(.page)
    }
}

struct ZoomImage_Previews: PreviewProvider {
    static var previews: some View {
        ZoomImage(currentLocation: LocationsDataService.locations.first!)
    }
}
