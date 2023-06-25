//
//  HeaderRestaurantView.swift
//  PratoAVista
//
//  Created by Beatriz Leonel da Silva on 21/06/23.
//

import SwiftUI
import MapKit

struct HeaderRestaurantView: View {
    
    let currentRestaurant: RestaurantModel
    @EnvironmentObject private var viewModel: RestaurantsViewModel
    
    @State var profileRatio: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 160 : 125
    @State var mapHeight: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 325 : 260
    @State private var orientation = UIDeviceOrientation.unknown
    
    var body: some View {
        VStack(spacing: 0) {
            mapLayer
            if let ckAsset = currentRestaurant.picture {
                if let uiImage = convertToUIImage(ckAsset: ckAsset) {
                    profileImage(uiImage: uiImage)
                        .offset(y: -3*(profileRatio/4))
                        .padding(.horizontal, 30)
                        .padding(.bottom, -profileRatio)
                }
            }
            
            Spacer()
            
        }
        .onRotate { newOrientation in
            orientation = newOrientation
        }
        .onAppear {
            if UIDevice.current.userInterfaceIdiom == .pad {
                mapHeight = 300
            }
            if UIDevice.current.userInterfaceIdiom == .phone {
                if orientation == .landscapeLeft || orientation == .landscapeRight {
                    mapHeight = 500
                } else {
                    mapHeight = 200
                }
            }
        }
    }
}

extension HeaderRestaurantView {
    
    private var mapLayer: some View {
        var currentMapHeight = mapHeight
        if orientation.isLandscape {
            currentMapHeight /= 1.5
        }
        
        return(
            Map(coordinateRegion: .constant(MKCoordinateRegion(
                center: viewModel.mapRestaurantCoordinate,
                span: viewModel.mapSpan)),
                annotationItems: [currentRestaurant]) { _ in
                    MapAnnotation(coordinate: viewModel.mapRestaurantCoordinate) {
                        LocationMapAnnotationView()
                    }
                }
                .frame(height: mapHeight)
                .allowsHitTesting(false)
        )
    }
    
    private func profileImage(uiImage: UIImage) -> some View {
        return (
            HStack {
                Spacer()
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: profileRatio, height: profileRatio)
                    .clipShape(Circle())
                    .onTapGesture {
                        viewModel.showSelectedImage()
                    }
            }
        )
    }
}


struct HeaderRestaurantView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderRestaurantView(currentRestaurant: RestaurantModel())
            .environmentObject(RestaurantsViewModel())
    }
}
