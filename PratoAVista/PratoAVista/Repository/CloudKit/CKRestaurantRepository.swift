//
//  RestaurantRepository.swift
//  PratoAVista
//
//  Created by Lais Godinho on 21/06/23.
//

import Foundation
import CloudKit

class CKRestaurantRepository {
    let publicDatabase = CKManager.shared.publicDatabase

    func getRestaurants() async -> [CKRestaurant]{
        let predicate = NSPredicate(value: true)

        do {
            let restaurants = try await getMatchingRecords(predicate: predicate)
            return restaurants
        } catch {
            fatalError()
        }
    }

    func getRestaurantBy(recordName: String) async -> CKRestaurant {
        let recordID = CKRecord.ID(recordName: recordName)
        let predicate = NSPredicate(format: "recordID == %@", recordID)

        do {
            let restaurants = try await getMatchingRecords(predicate: predicate)

            if restaurants.count > 0 {
                return restaurants[0]
            } else {
                //TODO: tratar erro
                fatalError("No restaurant with the given record name found")
            }
        } catch {
            fatalError()
        }
    }

    private func getMatchingRecords(predicate: NSPredicate) async throws -> [CKRestaurant] {

        let query = CKQuery(recordType: CKRestaurant.identifier, predicate: predicate)

        var restaurants: [CKRestaurant] = []
        let records = try await publicDatabase.records(matching: query)

        for item in records.matchResults {
            switch item.1 {
            case .success(let value):
                let restaurant = parseRecordToRestaurant(record: value)
                restaurants.append(restaurant)
            case .failure(let error):
                print(error)
            }
        }
        return restaurants
    }

    private func parseRecordToRestaurant(record: CKRecord) -> CKRestaurant {
        let restaurant = CKRestaurant(
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
