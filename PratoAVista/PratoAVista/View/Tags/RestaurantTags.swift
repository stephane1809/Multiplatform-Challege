//
//  RestaurantTags.swift
//  PratoAVista
//
//  Created by Beatriz Leonel da Silva on 21/06/23.
//

import SwiftUI

struct RestaurantTags: View {
    
    let tag: RestaurantTag
    
    var body: some View {
        HStack(spacing: 5) {
            Image(systemName: tag.icon)
                .resizable()
                .renderingMode(.template)
                .foregroundColor(.white)
                .scaledToFit()
                .frame(width: 15, height: 15)
            Text(tag.label)
                .foregroundColor(.white)
                .font(.caption)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 5)
        .background(Color.restaurantTagBG)
        .cornerRadius(20)
    }
}

struct RestaurantTags_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantTags(tag: .freeWifi)
    }
}
