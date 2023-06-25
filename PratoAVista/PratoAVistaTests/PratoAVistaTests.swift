//
//  PratoAVistaTests.swift
//  PratoAVistaTests
//
//  Created by Stephane Girão Linhares on 19/06/23.
//

import XCTest
@testable import PratoAVista

final class PratoAVistaTests: XCTestCase {

    var application: RestaurantsViewModel!
    
    override func setUpWithError() throws {
        application = RestaurantsViewModel()
    }

    override func tearDownWithError() throws {
        application = nil
    }
    
    func testShowSelectedImage() {
        application.showSelectedImage()
        XCTAssertTrue(application.selectedImage)
    }
    
    func testHideSelectedImage() {
        application.hideSelectedImage()
        XCTAssertFalse(application.selectedImage)
    }

    func testShowNextLocation() {
        let nextRestaurant = RestaurantModel()
        application.showNextRestaurant(newRestaurant: nextRestaurant)
        XCTAssertEqual(nextRestaurant, application.currentRestaurant)
    }
    
    func testNextButtonPressedWithNoError() {
        application.restaurants = [RestaurantModel(), RestaurantModel(), RestaurantModel()]
        let initialRestaurant = application.currentRestaurant
        application.nextButtonPressed()
        XCTAssertNotEqual(initialRestaurant, application.currentRestaurant)
    }
    
    func testNextButtonPressedWithErrorIndexNotFound() {
        application.restaurants = [RestaurantModel()]
        let currentCKRestaurant = RestaurantModel.cloudkit(recordName: "1")
        let restaurantModel = application.mapCKRestaurantsForRestaurantModel(ckRestaurants: [currentCKRestaurant])
        let currentRestaurant = restaurantModel[0]
        application.currentRestaurant = currentRestaurant
        application.nextButtonPressed()
        XCTAssertEqual(currentRestaurant, application.currentRestaurant)
    }
    
    func testNextButtonPressedReturnToFirstLocation() {
        application.restaurants = [RestaurantModel(), RestaurantModel(), RestaurantModel()]
        let firstRestaurantList = application.restaurants.first!
        application.currentRestaurant = application.restaurants.last!
        application.nextButtonPressed()
        XCTAssertEqual(firstRestaurantList, application.currentRestaurant)
    }
    
    func testNextButtonPressedWithEmptyLocationList() {
        application.restaurants = []
        let lastRestaurant = application.currentRestaurant
        application.nextButtonPressed()
        XCTAssertEqual(lastRestaurant, application.currentRestaurant)
    }
    
    func testFinishError() {
        application.localError = ErrorDescription(localizedDescription: "Test Error")
        application.finishError()
        XCTAssertNil(application.localError)
    }
    
    func testMapCKRestaurantsForRestaurantModel() {
        let initialCkRestaurants = [
            RestaurantModel.cloudkit(recordName: "1"),
            RestaurantModel.cloudkit(recordName: "2"),
            RestaurantModel.cloudkit(recordName: "3"),
            RestaurantModel.cloudkit(recordName: "4")
        ]
        let finalRestaurantsModel = application.mapCKRestaurantsForRestaurantModel(ckRestaurants: initialCkRestaurants)
        
        for (ckRestaurant, restaurantModel) in zip(initialCkRestaurants, finalRestaurantsModel) {
            XCTAssertEqual(ckRestaurant.recordName, restaurantModel.getCkRestaurant().recordName)
        }
    }

}
