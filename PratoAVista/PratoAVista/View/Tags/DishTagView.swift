//
//  DishTags.swift
//  PratoAVista
//
//  Created by Beatriz Leonel da Silva on 21/06/23.
//

import SwiftUI

struct DishTagView: View {
    
    let tag: DishTag
    
    var body: some View {
        HStack(spacing: 5) {
            Image(tag.icon)
                .resizable()
                .renderingMode(.template)
                .foregroundColor(.white)
                .scaledToFit()
                .frame(width: 20, height: 20)
            Text(tag.label)
                .foregroundColor(.white)
                .font(.caption)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 5)
        .background(Color.dishTagBG)
        .cornerRadius(20)
    }
}

struct DishTags_Previews: PreviewProvider {
    static var previews: some View {
        DishTagView(tag: .pig)
    }
}
