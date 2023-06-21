//
//  RestaurantModel.swift
//  PratoAVista
//
//  Created by Stephane Girão Linhares on 21/06/23.
//

import Foundation
import SwiftUI

struct RestaurantModel: Identifiable {
    var id = UUID()
    var name: String
    var image: String
    var location: String
    var distance: Int
}
