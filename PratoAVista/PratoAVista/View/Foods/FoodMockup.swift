//
//  FoodMockup.swift
//  PratoAVista
//
//  Created by Stephane Girão Linhares on 21/06/23.
//

import Foundation
import SwiftUI

class FoodMockup {

    static func getFoods() -> [FoodModel] {
            return [FoodModel(name: "Pizza de Frango", image: "almoco", price: 12),
                    FoodModel(name: "Pastel de Queijo", image: "almoco", price: 1),
                    FoodModel(name: "Coxinha", image: "almoco", price: 20),
                    FoodModel(name: "Bolo", image: "almoco", price: 6),
                    FoodModel(name: "Guarana", image: "almoco", price: 3),
            ]
        }
}
