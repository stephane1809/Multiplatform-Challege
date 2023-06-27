//
//  Dish.swift
//  PratoAVista
//
//  Created by Lais Godinho on 21/06/23.
//

import Foundation
import CloudKit

class BaseDish {
    var recordName: String
    var category: String?
    var dishName: String?
    var ingredients: [String]
    var portion: String?
    var price: Double?

    init(recordName: String, category: String? = nil, dishName: String? = nil, ingredients: [String] = [], portion: String? = nil, price: Double? = nil) {
        self.recordName = recordName
        self.category = category
        self.dishName = dishName
        self.ingredients = ingredients
        self.portion = portion
        self.price = price
    }
}

class Dish: BaseDish {
    var alergenics: [String]

    init(recordName: String,
         category: String? = nil,
         dishName: String? = nil,
         ingredients: [String] = [],
         portion: String? = nil,
         price: Double? = nil,
         alergenics: [String] = []) {
        self.alergenics = alergenics
        super.init(recordName: recordName,
                   category: category,
                   dishName: dishName,
                   ingredients: ingredients,
                   portion: portion, price: price)
    }
}

class CKDish: BaseDish {
    static let identifier = "Dish"
    var alergenics: [CKRecord.Reference]
    var restaurants: [CKRecord.Reference]

    init(recordName: String,
         category: String? = nil,
         dishName: String? = nil,
         ingredients: [String] = [],
         portion: String? = nil,
         price: Double? = nil,
         alergenics: [CKRecord.Reference] = [],
         restaurants: [CKRecord.Reference] = []) {
        self.alergenics = alergenics
        self.restaurants = restaurants
        super.init(recordName: recordName, category: category, dishName: dishName, ingredients: ingredients, portion: portion, price: price)
    }
}

class JSONDish: Codable, Identifiable {
    var id = UUID()
    var recordName: String
    var category: String?
    var dishName: String?
    var ingredients: [String]
    var portion: String?
    var price: Double?
    var alergenics: [String]

    init(recordName: String, category: String? = nil, dishName: String? = nil, ingredients: [String] = [], portion: String? = nil, price: Double? = nil, alergenics: [String] = []) {
        self.recordName = recordName
        self.category = category
        self.dishName = dishName
        self.ingredients = ingredients
        self.portion = portion
        self.price = price
        self.alergenics = alergenics
    }

    init(dish: Dish) {
        self.recordName = dish.recordName
        self.category = dish.category
        self.dishName = dish.dishName
        self.ingredients = dish.ingredients
        self.portion = dish.portion
        self.price = dish.price
        self.alergenics = dish.alergenics
    }
}
