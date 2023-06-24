//
//  RestaurantModel.swift
//  PratoAVista
//
//  Created by Lais Godinho on 21/06/23.
//

import Foundation
import CloudKit
import SwiftUI

struct RestaurantModel: Identifiable {
    var id = UUID()
    var name: String
    var image: String
    var location: String
    var distance: Int
    var tags: [RestaurantTag]
}

extension RestaurantModel {
    // swiftlint:disable: type_name
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

        init(recordName: String,
             fantasyName: String? = nil,
             city: String? = nil,
             latitude: String? = nil,
             longitude: String? = nil,
             neighborhood: String? = nil,
             number: String? = nil,
             state: String? = nil,
             streetName: String? = nil,
             storeCategories: [CKRecord.Reference] = [],
             operationDaysAndTime: String? = nil,
             instagram: String? = nil,
             picture: CKAsset? = nil,
             whatsapp: String? = nil,
             website: String? = nil,
             kids: String? = nil,
             petFriendly: String? = nil,
             airConditioned: String? = nil) {
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
