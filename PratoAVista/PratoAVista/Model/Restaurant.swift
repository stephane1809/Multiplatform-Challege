//
//  Restaurant.swift
//  PratoAVista
//
//  Created by Lais Godinho on 21/06/23.
//

import Foundation
import CloudKit
import UIKit

class BaseRestaurant {
    var recordName: String
    var fantasyName: String?
    var city: String?
    var latitude: String?
    var longitude: String?
    var neighborhood: String?
    var number: String?
    var state: String?
    var streetName: String?
    var operationDaysAndTime: String?
    var instagram: String?
    var whatsapp: String?
    var website: String?
    var kids: Bool
    var petFriendly: Bool
    var airConditioned: Bool

    init(recordName: String,
         fantasyName: String? = nil,
         city: String? = nil,
         latitude: String? = nil,
         longitude: String? = nil,
         neighborhood: String? = nil,
         number: String? = nil,
         state: String? = nil,
         streetName: String? = nil,
         operationDaysAndTime: String? = nil,
         instagram: String? = nil,
         whatsapp: String? = nil,
         website: String? = nil,
         kids: Bool = false,
         petFriendly: Bool = false,
         airConditioned: Bool = false) {
        self.recordName = recordName
        self.fantasyName = fantasyName
        self.city = city
        self.latitude = latitude
        self.longitude = longitude
        self.neighborhood = neighborhood
        self.number = number
        self.state = state
        self.streetName = streetName
        self.operationDaysAndTime = operationDaysAndTime
        self.instagram = instagram
        self.whatsapp = whatsapp
        self.website = website
        self.kids = kids
        self.petFriendly = petFriendly
        self.airConditioned = airConditioned
    }
}

class Restaurant: BaseRestaurant, Identifiable {
    var id = UUID()
    var picture: UIImage?

    init(recordName: String,
         fantasyName: String? = nil,
         city: String? = nil,
         latitude: String? = nil,
         longitude: String? = nil,
         neighborhood: String? = nil,
         number: String? = nil,
         state: String? = nil,
         streetName: String? = nil,
         operationDaysAndTime: String? = nil,
         instagram: String? = nil,
         whatsapp: String? = nil,
         website: String? = nil,
         kids: String? = nil,
         petFriendly: String? = nil,
         airConditioned: String? = nil,
         picture: UIImage? = nil) {

        var modifiedKids = false
        var modifiedPetFriendly = false
        var modifiedAirConditioned = false

        if kids != nil {
            if Int(kids!) == 1 {
                modifiedKids = true
            }
        }

        if petFriendly != nil {
            if Int(petFriendly!) == 1 {
                modifiedPetFriendly = true
            }
        }

        if airConditioned != nil {
            if Int(airConditioned!) == 1 {
                modifiedAirConditioned = true
            }
        }

        super.init(recordName: recordName,
                   fantasyName: fantasyName,
                   city: city,
                   latitude: latitude,
                   longitude: longitude,
                   neighborhood: neighborhood,
                   number: number,
                   state: state,
                   streetName: streetName,
                   operationDaysAndTime: operationDaysAndTime,
                   instagram: instagram,
                   whatsapp: whatsapp,
                   website: website,
                   kids: modifiedKids,
                   petFriendly: modifiedPetFriendly,
                   airConditioned: modifiedAirConditioned)
        self.picture = picture
    }

    init(recordName: String,
         fantasyName: String? = nil,
         city: String? = nil,
         latitude: String? = nil,
         longitude: String? = nil,
         neighborhood: String? = nil,
         number: String? = nil,
         state: String? = nil,
         streetName: String? = nil,
         operationDaysAndTime: String? = nil,
         instagram: String? = nil,
         whatsapp: String? = nil,
         website: String? = nil,
         kids: Bool = false,
         petFriendly: Bool = false,
         airConditioned: Bool = false,
         picture: UIImage? = nil) {
        super.init(recordName: recordName,
                   fantasyName: fantasyName,
                   city: city, latitude: latitude,
                   longitude: longitude,
                   neighborhood: neighborhood,
                   number: number,
                   state: state,
                   streetName: streetName,
                   operationDaysAndTime: operationDaysAndTime,
                   instagram: instagram,
                   whatsapp: whatsapp,
                   website: website,
                   kids: kids,
                   petFriendly: petFriendly,
                   airConditioned: airConditioned)
        self.picture = picture
    }
}

class CKRestaurant: BaseRestaurant {
    static let identifier = "Restaurant"
    var picture: CKAsset?

    init(recordName: String,
         fantasyName: String? = nil,
         city: String? = nil,
         latitude: String? = nil,
         longitude: String? = nil,
         neighborhood: String? = nil,
         number: String? = nil,
         state: String? = nil,
         streetName: String? = nil,
         operationDaysAndTime: String? = nil,
         instagram: String? = nil,
         picture: CKAsset? = nil,
         whatsapp: String? = nil,
         website: String? = nil,
         kids: String? = nil,
         petFriendly: String? = nil,
         airConditioned: String? = nil) {
        var modifiedKids = false
        var modifiedPetFriendly = false
        var modifiedAirConditioned = false

        if kids != nil {
            if Int(kids!) == 1 {
                modifiedKids = true
            }
        }

        if petFriendly != nil {
            if Int(petFriendly!) == 1 {
                modifiedPetFriendly = true
            }
        }

        if airConditioned != nil {
            if Int(airConditioned!) == 1 {
                modifiedAirConditioned = true
            }
        }

        super.init(recordName: recordName,
                   fantasyName: fantasyName,
                   city: city,
                   latitude: latitude,
                   longitude: longitude,
                   neighborhood: neighborhood,
                   number: number,
                   state: state,
                   streetName: streetName,
                   operationDaysAndTime: operationDaysAndTime,
                   instagram: instagram,
                   whatsapp: whatsapp,
                   website: website,
                   kids: modifiedKids,
                   petFriendly: modifiedPetFriendly,
                   airConditioned: modifiedAirConditioned)
        self.picture = picture
    }
}

class JSONRestaurant: Codable, Identifiable {
    var id = UUID()
    var recordName: String
    var fantasyName: String?
    var picturePath: String?
    var city: String?
    var latitude: String?
    var longitude: String?
    var neighborhood: String?
    var number: String?
    var state: String?
    var streetName: String?
    var operationDaysAndTime: String?
    var instagram: String?
    var whatsapp: String?
    var website: String?
    var kids: Bool
    var petFriendly: Bool
    var airConditioned: Bool
    var dishes: [JSONDish]

    init(recordName: String,
         fantasyName: String? = nil,
         picturePath: String? = nil,
         city: String? = nil,
         latitude: String? = nil,
         longitude: String? = nil,
         neighborhood: String? = nil,
         number: String? = nil,
         state: String? = nil,
         streetName: String? = nil,
         operationDaysAndTime: String? = nil,
         instagram: String? = nil,
         whatsapp: String? = nil,
         website: String? = nil,
         kids: Bool = false,
         petFriendly: Bool = false,
         airConditioned: Bool = false,
         dishes: [JSONDish] = []) {
        self.recordName = recordName
        self.fantasyName = fantasyName
        self.picturePath = picturePath
        self.city = city
        self.latitude = latitude
        self.longitude = longitude
        self.neighborhood = neighborhood
        self.number = number
        self.state = state
        self.streetName = streetName
        self.operationDaysAndTime = operationDaysAndTime
        self.instagram = instagram
        self.whatsapp = whatsapp
        self.website = website
        self.kids = kids
        self.petFriendly = petFriendly
        self.airConditioned = airConditioned
        self.dishes = dishes
    }

}
