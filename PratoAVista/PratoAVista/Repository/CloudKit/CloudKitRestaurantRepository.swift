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

    func getRestaurants() async -> [RestaurantModel.cloudkit]{
        let predicate = NSPredicate(value: true)

        do {
            let restaurants = try await getMatchingRecords(predicate: predicate)
            return restaurants
        } catch {
            fatalError()
        }
    }

    func getRestaurantBy(recordName: String) async -> [RestaurantModel.cloudkit]{
        let recordID = CKRecord.ID(recordName: recordName)
        let predicate = NSPredicate(format: "recordID == %@", recordID)

        do {
            let restaurants = try await getMatchingRecords(predicate: predicate)
            return restaurants
        } catch {
            fatalError()
        }
    }
    
    func getMatchingRecords(predicate: NSPredicate) async throws -> [RestaurantModel.cloudkit] {

        let query = CKQuery(recordType: RestaurantModel.cloudkit.identifier, predicate: predicate)

        var restaurants: [RestaurantModel.cloudkit] = []
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

    func parseRecordToRestaurant(record: CKRecord) -> RestaurantModel.cloudkit {
        let restaurant = RestaurantModel.cloudkit(
            id: record.recordID.recordName,
            fantasyName: record.object(forKey: "fantasyName")?.description,
            city: record.object(forKey: "city")?.description,
            latitude: record.object(forKey: "latitude")?.description,
            longitude: record.object(forKey: "longitude")?.description,
            neighborhood: record.object(forKey: "neighborhood")?.description,
            number: record.object(forKey: "number")?.description,
            state: record.object(forKey: "state")?.description,
            streetName: record.object(forKey: "streetName")?.description,
            operationDaysAndTime: record.object(forKey: "operationDaysAndTime")?.description,
            instagram: record.object(forKey: "instagram")?.description,
//            picture: record.object(forKey: "picture")?.description
            whatsapp: record.object(forKey: "whatsapp")?.description,
            website: record.object(forKey: "website")?.description,
            kids: record.object(forKey: "kids")?.description,
            petFriendly: record.object(forKey: "petFrinedly")?.description,
            airConditioned: record.object(forKey: "aitConditioned")?.description
        )

        return restaurant
    }
}
