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

            VStack(alignment: .leading, spacing: 5) {
                Text("Catálogo \(menu.name)")
                    .font(.system(size: 17))
                    .bold()

            }
            .foregroundColor(.black)
            Spacer()
            Image(menu.image)
                            .resizable()
                            .cornerRadius(10)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 81)
                            .padding(.top, 10)
                            .padding(.bottom, 10)

        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(red: 242/255, green: 242/255, blue: 247/255))
        .cornerRadius(5)
        .shadow(color: .gray, radius: 3, x: 4, y: 4)
    }
}
