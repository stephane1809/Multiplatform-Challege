//
//  JSONManager.swift
//  PratoAVista
//
//  Created by Lais Godinho on 22/06/23.
//

import Foundation
import UIKit

class JSONManager {
    static let shared = JSONManager()

    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    let folderURL: URL
    let fileURL: URL
//    let picturesURL: URL

    private init() {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        self.folderURL = documentsDirectory.appendingPathComponent(".pratoavista")
        self.fileURL = self.folderURL.appendingPathComponent("restaurants.json")
//        self.picturesURL = self.folderURL.appendingPathComponent("pictures")

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

//        if !fileManager.fileExists(atPath: picturesURL.path) {
//            do {
//                try fileManager.createDirectory(at: picturesURL, withIntermediateDirectories: true, attributes: nil)
//                print("Folder 'pictures' created successfully.")
//            } catch {
//                print("Error creating 'pictures' folder: \(error.localizedDescription)")
//            }
//        }
    }

    func saveRestaurants(_ restaurants: [JSONRestaurant]) {

        do {
            let data = try encoder.encode(restaurants)
            try data.write(to: fileURL)
            print("Restaurants saved successfully.")
        } catch {
            print("Error saving restaurants: \(error.localizedDescription)")
        }
    }

    func saveRestaurant(_ restaurant: JSONRestaurant) {
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

    func fetchBy(recordName: String) -> JSONRestaurant? {
        let savedRestaurantrs = loadRestaurants()

        let restaurant = savedRestaurantrs.first { restaurant in
            restaurant.recordName == recordName
        }

        return restaurant
    }

    func loadRestaurants() -> [JSONRestaurant] {
        do {
            let data = try Data(contentsOf: fileURL)
            let restaurants = try decoder.decode([JSONRestaurant].self, from: data)
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

//        if let picturePath = restaurants[index].picturePath {
//            ImageManager.deleteImageFile(at: picturePath)
//        }

        restaurants.remove(at: index)
        saveRestaurants(restaurants)
        print("Restaurant with recordName '\(recordName)' removed successfully.")
    }

}
