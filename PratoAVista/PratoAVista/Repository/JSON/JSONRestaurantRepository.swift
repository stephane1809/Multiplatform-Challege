//
//  JSONRestaurantRepository.swift
//  PratoAVista
//
//  Created by Lais Godinho on 22/06/23.
//

import Foundation

class JSONRestaurantRepository {
    static let shared = JSONRestaurantRepository()

    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private let folderURL: URL
    private let fileURL: URL
    private let picturesURL: URL

    private init() {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        self.folderURL = documentsDirectory.appendingPathComponent(".pratoavista")
        self.fileURL = self.folderURL.appendingPathComponent("restaurants.json")
        self.picturesURL = self.folderURL.appendingPathComponent("pictures")

        createFoldersIfNeeded()
    }

    private func createFoldersIfNeeded() {
        let fileManager = FileManager.default

        if !fileManager.fileExists(atPath: folderURL.path) {
            do {
                try fileManager.createDirectory(at: folderURL, withIntermediateDirectories: true, attributes: nil)
                print("Folder '.pratoavista' created successfully.")
            } catch {
                print("Error creating '.pratoavista' folder: \(error.localizedDescription)")
            }
        }
    }

    func saveRestaurants(_ restaurants: [Restaurant.JSON]) {
            var modifiedRestaurants = restaurants

            do {
                let data = try encoder.encode(modifiedRestaurants)
                try data.write(to: fileURL)
                print("Restaurants saved successfully.")
            } catch {
                print("Error saving restaurants: \(error.localizedDescription)")
            }
        }

    func saveRestaurant(_ restaurant: Restaurant.JSON) {
        var existingRestaurants = loadRestaurants()
        existingRestaurants.append(restaurant)

        do {
            let data = try encoder.encode(existingRestaurants)
            try data.write(to: fileURL)
            print("Restaurant saved successfully.")
        } catch {
            print("Error saving restaurant: \(error.localizedDescription)")
        }
    }

    func loadRestaurants() -> [Restaurant.JSON] {
        do {
            let data = try Data(contentsOf: fileURL)
            let restaurants = try decoder.decode([Restaurant.JSON].self, from: data)
            print("Restaurants loaded successfully.")
            return restaurants
        } catch {
            print("Error loading restaurants: \(error.localizedDescription)")
            return []
        }
    }

    func removeRestaurant(with recordName: String) {
        var restaurants = loadRestaurants()

        guard let index = restaurants.firstIndex(where: { $0.recordName == recordName }) else {
            print("Restaurant with recordName '\(recordName)' not found.")
            return
        }

        restaurants.remove(at: index)
        saveRestaurants(restaurants)
        print("Restaurant with recordName '\(recordName)' removed successfully.")
    }

}
