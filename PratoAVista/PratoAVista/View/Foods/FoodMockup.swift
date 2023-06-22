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
        return [FoodModel(name: "Pizza de Frango", image: "almoco", price: 12, tags: [DishTag.lactose, DishTag.fish, DishTag.soya, DishTag.egg]),
                FoodModel(name: "Pastel de Queijo", image: "almoco", price: 1, tags: [DishTag.crustacean, DishTag.celery, DishTag.pig]),
                FoodModel(name: "Coxinha", image: "almoco", price: 20, tags: [DishTag.egg, DishTag.peanut]),
                FoodModel(name: "Bolo", image: "almoco", price: 6, tags: [DishTag.lactose]),
                FoodModel(name: "Guarana", image: "almoco", price: 3, tags: [DishTag.fish]),
            ]
        }
}
