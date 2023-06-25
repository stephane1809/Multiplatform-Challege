//
//  DishModel.swift
//  PratoAVista
//
//  Created by Lais Godinho on 21/06/23.
//

import Foundation
import CloudKit

struct DishModel {
    
}

extension DishModel {
    // swiftlint:disable: type_name
    class cloudkit {
        static let identifier = "Dish"
        var recordName: String
        var category: String?
        var dishName: String?
        var ingredients: String?
        var portion: String?
        var price: Double?
        var restaurants: [CKRecord.Reference]

        init(recordName: String, category: String? = nil, dishName: String? = nil, ingredients: String? = nil, portion: String? = nil, price: Double? = nil, restaurants: [CKRecord.Reference] = []) {
            self.recordName = recordName
            self.category = category
            self.dishName = dishName
            self.ingredients = ingredients
            self.portion = portion
            self.price = price
            self.restaurants = restaurants
        }
    }
}
