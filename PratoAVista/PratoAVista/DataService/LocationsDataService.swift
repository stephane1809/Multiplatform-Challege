//
//  LocationsDataService.swift
//  PratoAVista
//
//  Created by Beatriz Leonel da Silva on 19/06/23.
//

import Foundation
import MapKit

class LocationsDataService {
    
    static let locations: [Location] = [
        Location(
            name: "Pasto & Pizzas",
            cityName: "13 de Maio",
            coordinates: CLLocationCoordinate2D(latitude: -3.750091315376614, longitude: -38.52843910105243),
            operation: "Segunda à Domomingo: 11h30 às 15h e 18h às 23h.",
            imageNames: [
                "Pasto13Out",
                "Pasto13Out2",
                "Pasto13Insta",
                "Pasto13In1",
                "Pasto13In2"
            ],
            link: "https://pastoepizzas.com.br",
            address: "Av. Treze de Maio, 1017 - Fátima, Fortaleza - CE, 60040-530"
        ),
        Location(
            name: "Emporium Pasto & Pizzas",
            cityName: "Eusébio",
            coordinates: CLLocationCoordinate2D(latitude: -3.8705360262752326, longitude: -38.46678373382564),
            operation: "Diariamente das 7h às 23h.",
            imageNames: [
                "EmporiumOut",
                "EmporiumIn",
                "EmporiumIn2",
            ],
            link: "https://pastoepizzas.com.br",
            address: "Av. Eusébio de Queiroz, 1890 - Amador, Eusébio - CE, 61760-000"
        ),
        Location(
            name: "Pasto & Pizzas",
            cityName: "Salinas",
            coordinates: CLLocationCoordinate2D(latitude: -3.7616880968402726, longitude: -38.481986127742),
            operation: "Segunda à Domomingo: 11:30h às 15h e 18h às 23h.",
            imageNames: [
                "salinasOut",
            ],
            link: "https://pastoepizzas.com.br",
            address: "Av. Washington Soares, 909 - Guararapes, Fortaleza - CE, 60811-340"
        ),
        Location(
            name: "Pasto & Pizzas",
            cityName: "Juazeiro do Norte",
            coordinates: CLLocationCoordinate2D(latitude: -7.237609541693556, longitude: -39.32381520460371),
            operation: "Segunda à Quintas: 11h30 às 15h e 18h às 0h. \nSexta à Domingo: 11h30 às 15h e 18h às 0h.",
            imageNames: [
                "JuazeiroOut",
                "JuazeiroIn1",
                "JuazeiroIn2",
            ],
            link: "https://pastoepizzas.com.br",
            address: "R. Odete Matos de Alencar, 590 - Lagoa Seca, Juazeiro do Norte - CE, 63040-250"
        ),
        Location(
            name: "Pasto & Pizzas",
            cityName: "Dom Luís",
            coordinates: CLLocationCoordinate2D(latitude: -3.7358678936119794, longitude: -38.48719204732186),
            operation: "Segunda à Domingo: 11h às 15h e 18h às 23h.",
            imageNames: [
                "DomLuisOut",
                "DomLuisIn"
            ],
            link: "https://pastoepizzas.com.br",
            address: "Av. Júlio Abreu, 160 - Varjota, Fortaleza - CE, 60160-240"
        ),
    ]
    
}

