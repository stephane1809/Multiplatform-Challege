//
//  RestaurantMockup.swift
//  PratoAVista
//
//  Created by Stephane Girão Linhares on 21/06/23.
//

import Foundation
import SwiftUI

class RestaurantMockup {

    static func getRestaurants() -> [RestaurantModel] {
        return [RestaurantModel(name: "Pasto & Pizza", image: "pastoLogo", location: "Av. Treze de Maio, 1017 - Fátima", distance: 12, tags: [RestaurantTag.freeWifi, RestaurantTag.petFrendly, RestaurantTag.withAirConditioning]),
                    RestaurantModel(name: "Pastel do Marcos", image: "floresta", location: "rua das carnaúbas", distance: 1, tags: [RestaurantTag.freeWifi]),
                    RestaurantModel(name: "Pizza do Joao", image: "barneys", location: "av. do rio branco", distance: 20, tags: [RestaurantTag.freeWifi]),
                    RestaurantModel(name: "Doce Joana", image: "pasto", location: "av. paulista", distance: 6, tags: [RestaurantTag.freeWifi]),
                    RestaurantModel(name: "Guarana da Ana", image: "pasto", location: "silas munguba", distance: 3, tags: [RestaurantTag.freeWifi]),
            ]
        }
}
