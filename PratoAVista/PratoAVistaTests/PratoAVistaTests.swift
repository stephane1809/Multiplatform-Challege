//
//  PratoAVistaTests.swift
//  PratoAVistaTests
//
//  Created by Stephane Girão Linhares on 19/06/23.
//

import XCTest
@testable import PratoAVista

final class PratoAVistaTests: XCTestCase {

    var application: LocationsViewModel!
    
    override func setUpWithError() throws {
        application = LocationsViewModel()
    }

    override func tearDownWithError() throws {
        application = nil
    }
    
    func testToggleLocationsList() {
        let initialBool = application.showLocationsList
        application.toggleLocationsList()
        let result = application.showLocationsList
        XCTAssertNotEqual(initialBool, result)
    }

    func testShowNextLocation() {
        let nextLocation = Location(
            name: "IFCE",
            cityName: "Fortaleza",
            coordinates: .init(
                latitude: -3.744009076657496,
                longitude: -38.5360111593857),
            operation: "",
            imageNames: [],
            link: "https://ifce.edu.br",
            address: "Av. Treze de Maio, 2081 - Benfica, Fortaleza - CE, 60040-531")
        application.showNextLocation(location: nextLocation)
        XCTAssertEqual(nextLocation, application.mapLocation)
    }
    
    func testNextButtonPressedWithNoError() {
        let initialMapLocation = application.mapLocation
        application.nextButtonPressed()
        XCTAssertNotEqual(initialMapLocation, application.mapLocation)
    }
    
    func testNextButtonPressedWithErrorIndexNotFound() {
        let currentLocation = Location(
            name: "IFCE",
            cityName: "Fortaleza",
            coordinates: .init(
                latitude: -3.744009076657496,
                longitude: -38.5360111593857),
            operation: "",
            imageNames: [],
            link: "https://ifce.edu.br",
            address: "Av. Treze de Maio, 2081 - Benfica, Fortaleza - CE, 60040-531")
        application.mapLocation = currentLocation
        application.nextButtonPressed()
        XCTAssertEqual(currentLocation, application.mapLocation)
    }
    
    func testNextButtonPressedReturnToFirstLocation() {
        let firstLocationInList = application.locations.first!
        application.mapLocation = application.locations.last!
        application.nextButtonPressed()
        XCTAssertEqual(firstLocationInList, application.mapLocation)
    }
    
    func testNextButtonPressedWithEmptyLocationList() {
        let lastLocation = application.mapLocation
        application.locations = []
        application.nextButtonPressed()
        XCTAssertEqual(lastLocation, application.mapLocation)
    }

}
