//
//  RestaurantTag.swift
//  PratoAVista
//
//  Created by Beatriz Leonel da Silva on 21/06/23.
//

import Foundation

enum RestaurantTag {
    case withAirConditioning
    case petFrendly
    case freeWifi
    
    var label: String {
        switch self {
        case .withAirConditioning:
            return "Climatizado"
        case .petFrendly:
            return "Pet friendly"
        case .freeWifi:
            return "Wi-fi"
        }
    }

    var icon: String {
        switch self {
        case .withAirConditioning:
            return "snowflake"
        case .petFrendly:
            return "pawprint.fill"
        case .freeWifi:
            return "wifi"
        }
    }
}


