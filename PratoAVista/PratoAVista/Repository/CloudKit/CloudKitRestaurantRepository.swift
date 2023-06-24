//
//  RestaurantRepository.swift
//  PratoAVista
//
//  Created by Lais Godinho on 21/06/23.
//

import Foundation
import CloudKit

class CloudKitRestaurantRepository {
    let publicDatabase = CKManager.shared.publicDatabase

    func getRestaurants() async throws -> [RestaurantModel.cloudkit] {
        let predicate = NSPredicate(value: true)

        do {
            let restaurants = try await getMatchingRecords(predicate: predicate)
            return restaurants
        } catch {
            throw error
        }
    }

    func getRestaurantBy(recordName: String) async throws -> [RestaurantModel.cloudkit]{
        let recordID = CKRecord.ID(recordName: recordName)
        let predicate = NSPredicate(format: "recordID == %@", recordID)

        do {
            let restaurants = try await getMatchingRecords(predicate: predicate)
            return restaurants
        } catch {
            throw error
        }
    }
    
    private func getMatchingRecords(predicate: NSPredicate) async throws -> [RestaurantModel.cloudkit] {

        let query = CKQuery(recordType: RestaurantModel.cloudkit.identifier, predicate: predicate)

        var restaurants: [RestaurantModel.cloudkit] = []
        let records = try await publicDatabase.records(matching: query)

        for item in records.matchResults {
            switch item.1 {
            case .success(let value):
                let restaurant = parseRecordToRestaurant(record: value)
                restaurants.append(restaurant)
            case .failure(let error):
                throw error
            }
        }
        return restaurants
    }

    private func parseRecordToRestaurant(record: CKRecord) -> RestaurantModel.cloudkit {
        let restaurant = RestaurantModel.cloudkit(
            recordName: record.recordID.recordName,
            fantasyName: record["fantasyName"],
            city: record["city"],
            latitude: record["latitude"],
            longitude: record["longitude"],
            neighborhood: record["neighborhood"],
            number: record["number"],
            state: record["state"],
            streetName: record["streetName"],
            operationDaysAndTime: record["operationDaysAndTime"],
            instagram: record["instagram"],
            picture: record["picture"],
            whatsapp: record["whatsapp"],
            website: record["website"],
            kids: record["kids"],
            petFriendly: record["petFrinedly"],
            airConditioned: record["aitConditioned"]
        )

        return restaurant
    }
}
