//
//  LocationMapAnnotationView.swift
//  PratoAVista
//
//  Created by Beatriz Leonel da Silva on 19/06/23.
//

import SwiftUI
import MapKit

struct LocationMapAnnotationView: View {
    var accentColor = Color.red
    var systemIcon = "fork.knife.circle.fill"
//    map.circle.fill
//    fork.knife.circle.fill
//    "book.circle.fill"
    var body: some View {
        VStack(spacing: 0) {
            Image(systemName: systemIcon)
                .resizable()
                .scaledToFit()
                .foregroundColor(.white)
                .frame(width: 30, height: 30)
                .padding(6)
                .background(accentColor)
                .cornerRadius(36)
            
            Image(systemName: "triangle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 10, height: 10)
                .foregroundColor(accentColor)
                .rotationEffect(.init(degrees: 180))
                .offset(y: -3)
                .padding(.bottom, 40)
        }
    }
}

struct LocationMapAnnotationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationMapAnnotationView()
    }
}
