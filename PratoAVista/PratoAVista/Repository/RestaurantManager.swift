//
//  RestaurantManager.swift
//  PratoAVista
//
//  Created by Lais Godinho on 24/06/23.
//

import Foundation
import CloudKit
import UIKit

class RestaurantManager {
    private var cloudKitRestaurantRepository = CKRestaurantRepository()
    private var dishManager = DishManager()
    private var jsonManager = JSONManager.shared

//    func getRestaurants() {
//
//    }

//    func getRestaurant(recordName: String) -> Restaurant {
//        guard let restaurant = getRestaurantFromDevice(recordName: recordName) else {
//            //TODO: pegar do cloudkit caso n esteja salvo no aparelho
//            fatalError()
//        }
//
//        return restaurant
//    }

    func getRestaurantFromCloudKit(recordName: String) async -> CKRestaurant {
        let restaurant = await CKRestaurantRepository().getRestaurantBy(recordName: "7603F070-33F1-81AB-7462-E242F1B20A93")

        return restaurant
    }

    func getRestaurantFromDevice(recordName: String) -> JSONRestaurant {
        guard let jsonRestaurant = jsonManager.fetchBy(recordName: recordName) else {
            print("There are no restaurants with the provided record name saved on device")
            fatalError()
        }

        return jsonRestaurant
    }

    func getRestaurantsFromDevice() -> [JSONRestaurant] {
        let jsonRestaurants = jsonManager.loadRestaurants()

        return jsonRestaurants
    }

    func saveRestaurant(recordName: String) async {
        let cloudKitRestaurant = await cloudKitRestaurantRepository.getRestaurantBy(recordName: recordName)
        let dishes = await dishManager.getDishesBy(restaurantRecordName: recordName)
        print(dishes.count)

        var jsonDishes: [JSONDish] = []

        for dish in dishes {
            jsonDishes.append(JSONDish(dish: dish))
        }

        let jsonRestaurant = parseToJSONRestaurant(cloudKitRestaurant: cloudKitRestaurant, dishes: jsonDishes)

        jsonManager.saveRestaurant(jsonRestaurant)
    }

    func removeFromSaved(recordName: String) {
        jsonManager.removeRestaurant(with: recordName)
    }

//    func saveRestaurantPicture(restaurant: CKRestaurant) -> String {
//        guard let pictureAsset = restaurant.picture else {
//            // TODO: tratar erro
//            fatalError("Picture value is nil")
//        }
//
//        let restaurantPictureData = ImageManager.parseCKAssetToData(asset: pictureAsset)
//        let pictureURL = jsonManager.picturesURL.appendingPathComponent("\(restaurant.recordName).png")
//        ImageManager.saveImage(fileURL: pictureURL, imageData: restaurantPictureData)
//
//        return pictureURL.path
//
//    }

    func parseToJSONRestaurant(cloudKitRestaurant cloudKitObject: CKRestaurant, dishes: [JSONDish]) -> JSONRestaurant {
//        let picturePath = saveRestaurantPicture(restaurant: cloudKitObject)
        let jsonRestaurant = JSONRestaurant(recordName: cloudKitObject.recordName,
                                            fantasyName: cloudKitObject.fantasyName,
                                            city: cloudKitObject.city,
                                            latitude: cloudKitObject.latitude,
                                            longitude: cloudKitObject.longitude,
                                            neighborhood: cloudKitObject.neighborhood,
                                            number: cloudKitObject.number,
                                            state: cloudKitObject.state,
                                            streetName: cloudKitObject.streetName,
                                            operationDaysAndTime: cloudKitObject.operationDaysAndTime,
                                            instagram: cloudKitObject.instagram,
                                            whatsapp: cloudKitObject.whatsapp,
                                            website: cloudKitObject.website,
                                            kids: cloudKitObject.kids,
                                            petFriendly: cloudKitObject.petFriendly,
                                            airConditioned: cloudKitObject.airConditioned,
                                            dishes: dishes)

        return jsonRestaurant
    }

//    func parseToRestaurant(ckRestaurant: CKRestaurant) -> Restaurant {
//        let restaurant = Restaurant(recordName: <#T##String#>,
//                                    fantasyName: <#T##String?#>,
//                                    city: <#T##String?#>,
//                                    latitude: <#T##String?#>,
//                                    longitude: <#T##String?#>,
//                                    neighborhood: <#T##String?#>,
//                                    number: <#T##String?#>,
//                                    state: <#T##String?#>,
//                                    streetName: <#T##String?#>,
//                                    operationDaysAndTime: <#T##String?#>,
//                                    instagram: <#T##String?#>,
//                                    whatsapp: <#T##String?#>,
//                                    website: <#T##String?#>,
//                                    kids: <#T##Bool#>,
//                                    petFriendly: <#T##Bool#>,
//                                    airConditioned: <#T##Bool#>,
//                                    picture: <#T##UIImage?#>)
//    }

    func parseToRestaurant(jsonRestaurant: JSONRestaurant) -> Restaurant {
//        guard let picturePath = jsonRestaurant.picturePath else {
//            //TODO: tratar erro
//            fatalError("Picture path is nil")
//        }
//
//        guard let pictureURL = URL(string: picturePath) else {
//            //TODO: tratar erro
//            fatalError("Error getting picture URL from string")
//        }
//
//        let pictureData = ImageManager.getImageData(fileURL: pictureURL)

//        let uiImage = ImageManager.parseDataToUIImage(data: pictureData)

        let restaurant = Restaurant(recordName: jsonRestaurant.recordName,
                                    fantasyName: jsonRestaurant.fantasyName,
                                    city: jsonRestaurant.city,
                                    latitude: jsonRestaurant.latitude,
                                    longitude: jsonRestaurant.longitude,
                                    neighborhood: jsonRestaurant.neighborhood,
                                    number: jsonRestaurant.number,
                                    state: jsonRestaurant.state,
                                    streetName: jsonRestaurant.streetName,
                                    operationDaysAndTime: jsonRestaurant.operationDaysAndTime,
                                    instagram: jsonRestaurant.instagram,
                                    whatsapp: jsonRestaurant.whatsapp,
                                    website: jsonRestaurant.website,
                                    kids: jsonRestaurant.kids,
                                    petFriendly: jsonRestaurant.petFriendly,
                                    airConditioned: jsonRestaurant.airConditioned)

        return restaurant
    }


}

class ImageManager {
    static func parseCKAssetToData(asset: CKAsset) -> Data {
        guard let fileURL = asset.fileURL else {
            // Handle error if the file URL is nil
            fatalError("Error getting asset's fileURL")
        }

        let imageData = getImageData(fileURL: fileURL)

        return imageData
    }

    static func getImageData(fileURL: URL) -> Data {
        guard let imageData = try? Data(contentsOf: fileURL) else {
            // Handle error if the image data cannot be loaded
            fatalError("Error loading contents from fileURL to data")
        }

        return imageData
    }

    static func parseDataToUIImage(data: Data) -> UIImage {
        guard let image = UIImage(data: data) else {
            // Handle error if the image cannot be created from the data
            fatalError("Error getting image from data")
        }

        return image
    }

    static func saveImage(fileURL: URL, imageData: Data) {
        do {
            try imageData.write(to: fileURL)
            print("image saved at \(fileURL.path)")
            // Image saved successfully
        } catch {
            // Handle error if the image data cannot be written to the file URL
            fatalError("Could not save image")
        }
    }

    static func deleteImageFile(at path: String) {
            do {
                try FileManager.default.removeItem(atPath: path)
                print("Image file at path '\(path)' deleted successfully.")
            } catch {
                print("Error deleting image file at path '\(path)': \(error.localizedDescription)")
            }
        }
}
