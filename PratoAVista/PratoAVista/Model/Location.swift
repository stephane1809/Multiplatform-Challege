//
//  Location.swift
//  PratoAVista
//
//  Created by Beatriz Leonel da Silva on 19/06/23.
//

import Foundation
import MapKit

struct Location: Identifiable, Equatable {

    let name: String
    let cityName: String
    let coordinates: CLLocationCoordinate2D
    let operation: String
    let imageNames: [String]
    let link: String
    let address: String
    
    var id: String {
        name + cityName
    }
    
    static func == (lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}
