//
//  CloudKitDishRepository.swift
//  PratoAVista
//
//  Created by Lais Godinho on 21/06/23.
//

import Foundation
import CloudKit

class CKDishRepository {
    let publicDatabase = CKManager.shared.publicDatabase

    func getDishBy(recordName: String) async -> [CKDish] {
        let recordID = CKRecord.ID(recordName: recordName)
        let predicate = NSPredicate(format: "recordID == %@", recordID)

        do {
            let dishes = try await getMatchingRecords(predicate: predicate)
            return dishes
        } catch {
            fatalError()
        }
    }

    func getDishesBy(restaurantRecordName: String) async -> [CKDish] {
        let restaurantRecordID = CKRecord.ID(recordName: restaurantRecordName)
        let predicate = NSPredicate(format: "restaurants CONTAINS %@", restaurantRecordID)

        do {
            let dishes = try await getMatchingRecords(predicate: predicate)
            return dishes
        } catch {
            fatalError()
        }
    }

//    func getRestaurants() async -> [RestaurantModel.cloudkit]{
//
//    }
//
//    func getRestaurantBy(recordName: String) async -> [RestaurantModel.cloudkit]{
//
//    }
//
    private func getMatchingRecords(predicate: NSPredicate) async throws -> [CKDish] {

        let query = CKQuery(recordType: CKDish.identifier, predicate: predicate)

        var dishes: [CKDish] = []
        let records = try await publicDatabase.records(matching: query)

        for item in records.matchResults {
            switch item.1 {
            case .success(let value):
                let dish = parseRecordToDish(record: value)
                dishes.append(dish)
            case .failure(let error):
                print(error)
            }
        }
        return dishes
    }
//
    private func parseRecordToDish(record: CKRecord) -> CKDish {
        let alergenics = getAlergenicsReferences(record: record)
        let ingredients = getIngredients(record: record)

        let restaurant = CKDish(
            recordName: record.recordID.recordName,
            category: record["category"],
            dishName: record["dishName"],
            ingredients: ingredients,
            portion: record["portion"],
            price: record["price"],
            alergenics: alergenics
//            restaurants: ingredients
        )

        return restaurant
    }

    func parseCKDishToDish(ckDish: CKDish, alergenics: [String]) -> Dish {
        let dish = Dish(recordName: ckDish.recordName,
                        category: ckDish.category,
                        dishName: ckDish.dishName,
                        ingredients: ckDish.ingredients,
                        portion: ckDish.portion,
                        price: ckDish.price,
                        alergenics: alergenics)

        return dish
    }

    private func getAlergenicsReferences(record: CKRecord) -> [CKRecord.Reference] {
        guard let alergenics = record["alergenics"] as? [CKRecord.Reference] else {
            return []
        }

        return alergenics
    }

    private func getIngredients(record: CKRecord) -> [String] {
        guard let ingredients = record["ingredients"] as? [String] else {
            return []
        }

        return ingredients
    }


}

class CloudKitAlergenicRepository {
    let publicDatabase = CKManager.shared.publicDatabase

   func getAlergenicBy(recordReference: CKRecord.Reference) async -> [CKAlergenic] {
//        let recordn = CKRecord.ID()
        let recordID = recordReference.recordID
        let predicate = NSPredicate(format: "recordID == %@", recordID)

        do {
            let alergenics = try await getMatchingRecords(predicate: predicate)
            return alergenics
        } catch {
            fatalError()
        }
    }

    private func getMatchingRecords(predicate: NSPredicate) async throws -> [CKAlergenic] {

        let query = CKQuery(recordType: CKAlergenic.identifier, predicate: predicate)

        var alergenics: [CKAlergenic] = []
        let records = try await publicDatabase.records(matching: query)

        for item in records.matchResults {
            switch item.1 {
            case .success(let value):
                let alergenic = parseRecordToAlergenic(record: value)
                alergenics.append(alergenic)
            case .failure(let error):
                print(error)
            }
        }
        return alergenics
    }

    func parseRecordToAlergenic(record: CKRecord) -> CKAlergenic {
        return CKAlergenic(type: getTypeString(record: record))
    }

    private func getTypeString(record: CKRecord) -> String? {
        guard let alergenic = record["type"] as? String else {
            return nil
        }

        return alergenic
    }
}

class CKAlergenic {
    static let identifier = "Alergenic"
    var type: String?

    init(type: String? = nil) {
        self.type = type
    }
}
