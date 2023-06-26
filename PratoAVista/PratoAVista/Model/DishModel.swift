//
//  DishModel.swift
//  PratoAVista
//
//  Created by Lais Godinho on 21/06/23.
//

import Foundation
import CloudKit

struct DishModel: Hashable, Identifiable, Equatable {

    private var ckDish: cloudkit

    init(ckDish: cloudkit) {
        self.ckDish = ckDish
    }
    
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(id.uuidString)
    }

    let id = UUID()

    var name: String? { get { return  ckDish.dishName } }
    var category: String? { get { return ckDish.category } }
    var ingredients: String? { get { return ckDish.ingredients } }
    var portion: String? { get { return ckDish.portion } }
    var price: Double? { get { return ckDish.price } }
    var restaurants: [CKRecord.Reference]? { get { return ckDish.restaurants } }

    static func == (lhs: DishModel, rhs: DishModel) -> Bool {
        if lhs.ckDish.recordName == rhs.ckDish.recordName {
            return lhs.id == rhs.id
        }
        return false
    }
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

        init (
            recordName: String,
            category: String? = nil,
            dishName: String? = nil,
            ingredients: String? = nil,
            portion: String? = nil,
            price: Double? = nil,
            restaurants: [CKRecord.Reference] = []) {
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
