//
//  MenuCard.swift
//  PratoAVista
//
//  Created by Stephane Girão Linhares on 21/06/23.
//

import Foundation
import SwiftUI

struct MenuCard: View {

    var menu: MenuModel

    var body: some View {
        HStack(alignment: .top) {

            VStack(alignment: .leading, spacing: 10) {
                Text("Catálogo \(menu.name)")
                    .font(.system(size: 17))
                    .bold()
                    .padding(.vertical, 10)

                HStack(spacing: 5) {
                    Text("Ver menu")
                        .foregroundColor(.black)
                        .font(.caption)
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 10)
                .background(.white)
                .cornerRadius(20)
            }
            .foregroundColor(.black)
            Spacer()
            Image(menu.image)
                            .resizable()
                            .cornerRadius(10)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 81)
                            .padding(.top, 5)
                            .padding(.bottom, 5)

        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(red: 242/255, green: 242/255, blue: 247/255))
        .cornerRadius(5)
        .shadow(color: .gray, radius: 3, x: 4, y: 4)
    }
}
