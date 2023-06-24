//
//  CloudKitDishRepository.swift
//  PratoAVista
//
//  Created by Lais Godinho on 21/06/23.
//

import Foundation
import CloudKit

class CloudKitDishRepository {
    let publicDatabase = CKManager.shared.publicDatabase

    func getDishesBy(restaurantRecordName: String) async throws -> [DishModel.cloudkit] {
        let restaurantRecordID = CKRecord.ID(recordName: restaurantRecordName)
        let predicate = NSPredicate(format: "restaurants CONTAINS %@", restaurantRecordID)

        do {
            let dishes = try await getMatchingRecords(predicate: predicate)
            return dishes
        } catch {
            throw error
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
    private func getMatchingRecords(predicate: NSPredicate) async throws -> [DishModel.cloudkit] {

        let query = CKQuery(recordType: DishModel.cloudkit.identifier, predicate: predicate)

        var dishes: [DishModel.cloudkit] = []
        let records = try await publicDatabase.records(matching: query)

        for item in records.matchResults {
            switch item.1 {
            case .success(let value):
                let restaurant = parseRecordToDish(record: value)
                dishes.append(restaurant)
            case .failure(let error):
                throw error
            }
        }
        return dishes
    }
//
    private func parseRecordToDish(record: CKRecord) -> DishModel.cloudkit {
        let restaurant = DishModel.cloudkit(
            recordName: record.recordID.recordName,
            category: record["category"],
            dishName: record["dishName"],
            ingredients: record["ingredients"],
            portion: record["portion"],
            price: record["price"]
//            restaurants: record["restaurants"]
        )

        return restaurant
    }
}
