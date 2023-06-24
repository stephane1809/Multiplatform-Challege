//
//  RestaurantModel.swift
//  PratoAVista
//
//  Created by Lais Godinho on 21/06/23.
//

import Foundation
import CloudKit
import SwiftUI

struct RestaurantModel: Identifiable, Equatable {
    static func == (lhs: RestaurantModel, rhs: RestaurantModel) -> Bool {
        lhs.ckRestaurant.recordName == rhs.ckRestaurant.recordName
    }
    
    var id = UUID()
    var name: String? { get { ckRestaurant.fantasyName } }
    var image: String?
    var coordinate: CLLocationCoordinate2D {
        let latitude = ckRestaurant.latitude!
        let longitude = ckRestaurant.longitude!
        return convertLatitudeLogitudeStringToCoordinate(latitude: latitude, longitude: longitude)
    }
    
    func convertLatitudeLogitudeStringToCoordinate(latitude: String, longitude: String) -> CLLocationCoordinate2D {
        var latitudeFloat: CGFloat = 0
        var longitudeFloat: CGFloat = 0
        let formatter = NumberFormatter()
        formatter.decimalSeparator = "."
        if let number = formatter.number(from: latitude) {
            latitudeFloat = CGFloat(truncating: number)
        }
        if let number = formatter.number(from: longitude) {
            longitudeFloat = CGFloat(truncating: number)
        }
        return .init(latitude: latitudeFloat, longitude: longitudeFloat)
    }
    
    var location: String? {
        get {
            var address: String?
            if let street = ckRestaurant.streetName {
                address = street
                if let number = ckRestaurant.number {
                    address = address! + ", " + number
                }
            }
            return address
        }
    }
    
    var operation: String? {
        get {
            var ckOperation: String?
            if let timeWork = ckRestaurant.operationDaysAndTime {
                ckOperation = timeWork
            }
            return ckOperation
        }
    }
    
    var whatsapp: String? {
        get {
            var telephone: String?

            if let contact = ckRestaurant.whatsapp {
                telephone = contact
            }
            
            return telephone
        }
    }
    
    var wifi: Bool { get { return ckRestaurant.airConditioned } }
    
    var airConditioned: Bool { get { ckRestaurant.airConditioned } }
    
    var petFrendly: Bool { get { ckRestaurant.petFriendly } }
    
    var kidsArea: Bool { get { ckRestaurant.kids } }
    
    var picture: CKAsset? { get { ckRestaurant.picture } }
    
    var latitude: String? { get { ckRestaurant.latitude } }
    
    var longitude: String? { get { ckRestaurant.longitude } }
    
    
    var distance: Int?
    var tags: [RestaurantTag]?
    private var ckRestaurant: cloudkit
    
    init(id: UUID = UUID(), image: String? = nil, distance: Int? = nil, tags: [RestaurantTag]? = nil, ckRestaurant: cloudkit = cloudkit(recordName: "")) {
        self.id = id
        self.image = image
        self.distance = distance
        self.tags = tags
        self.ckRestaurant = ckRestaurant
    }
}

extension RestaurantModel {
    class cloudkit {
        static let identifier = "Restaurant"
        var recordName: String
        var fantasyName: String?
        var city: String?
        var latitude: String?
        var longitude: String?
        var neighborhood: String?
        var number: String?
        var state: String?
        var streetName: String?
        var storeCategories: [CKRecord.Reference]
        var operationDaysAndTime: String?
        var instagram: String?
        var picture: CKAsset?
        var whatsapp: String?
        var website: String?
        var kids: Bool
        var petFriendly: Bool
        var airConditioned: Bool

        init(recordName: String, fantasyName: String? = nil, city: String? = nil, latitude: String? = nil, longitude: String? = nil, neighborhood: String? = nil, number: String? = nil, state: String? = nil, streetName: String? = nil, storeCategories: [CKRecord.Reference] = [], operationDaysAndTime: String? = nil, instagram: String? = nil, picture: CKAsset? = nil, whatsapp: String? = nil, website: String? = nil, kids: String? = nil, petFriendly: String? = nil, airConditioned: String? = nil) {
            self.recordName = recordName
            self.fantasyName = fantasyName
            self.city = city
            self.latitude = latitude
            self.longitude = longitude
            self.neighborhood = neighborhood
            self.number = number
            self.state = state
            self.streetName = streetName
            self.storeCategories = storeCategories
            self.operationDaysAndTime = operationDaysAndTime
            self.instagram = instagram
            self.picture = picture
            self.whatsapp = whatsapp
            self.website = website

            if kids != nil {
                if Int(kids!) == 1 {
                    self.kids = true
                } else {
                    self.kids = false
                }
            } else {
                self.kids = false
            }

            if petFriendly != nil {
                if Int(petFriendly!) == 1 {
                    self.petFriendly = true
                } else {
                    self.petFriendly = false
                }
            } else {
                self.petFriendly = false
            }

            if airConditioned != nil {
                if Int(airConditioned!) == 1 {
                    self.airConditioned = true
                } else {
                    self.airConditioned = false
                }
            } else {
                self.airConditioned = false
            }
        }
    }
}



struct Address {
    var city: String
    var latitude: String
    var longitude: String
    var neighborhood: String
    var number: String
    var state: String
    var streetName: String
    var zipcode: String
}
