//
//  HeaderRestaurantView.swift
//  PratoAVista
//
//  Created by Beatriz Leonel da Silva on 21/06/23.
//

import SwiftUI
import MapKit

struct HeaderRestaurantView: View {
    
    let currentLocation: Location
    @EnvironmentObject private var viewModel: LocationsViewModel
    
    @State var profileRatio: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 160 : 125
    @State var mapHeight: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 325 : 260
    @State var orientation = UIDevice.current.orientation
    
    var body: some View {
        VStack(spacing: 0) {
            mapLayer
            profileImage
                .offset(y: -3*(profileRatio/4))
                .padding(.horizontal, 30)
                .padding(.bottom, -profileRatio)
            
            Spacer()
            
        }
        .detectOrientation($orientation)
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
            currentMapHeight = currentMapHeight/1.5
        }
        
        return(
            Map(coordinateRegion: .constant(MKCoordinateRegion(
                center: currentLocation.coordinates,
                span: viewModel.mapSpan)),
                annotationItems: [currentLocation]) { location in
                    MapAnnotation(coordinate: location.coordinates) {
                        LocationMapAnnotationView()
                    }
                }
                .frame(height: mapHeight)
                .allowsHitTesting(false)
        )
    }
    
    private var profileImage: some View {
        return (
            HStack {
                Spacer()
                Image(currentLocation.imageNames.first!)
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
        HeaderRestaurantView(currentLocation: LocationsDataService.locations.first!)
            .environmentObject(LocationsViewModel())
    }
}
