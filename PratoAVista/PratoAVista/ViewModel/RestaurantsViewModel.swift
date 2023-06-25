//
//  LocationViewModel.swift
//  PratoAVista
//
//  Created by Beatriz Leonel da Silva on 19/06/23.
//

import Foundation
import MapKit
import SwiftUI
import CloudKit

class RestaurantsViewModel: ObservableObject {

    @Published var restaurants: [RestaurantModel] = [] {
        didSet {
            currentRestaurant = restaurants.first ?? RestaurantModel()
        }
    }

    // Current Restaurant in Map
    @Published var currentRestaurant: RestaurantModel {
        didSet {
            mapRestaurantCoordinate = currentRestaurant.coordinate
            Task {
                await fetchDishes()
            }
        }
    }

    // Current Map Restaurant Coordinate
    @Published var mapRestaurantCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2D() {
        didSet {
            updateMapRegion(coordinate: mapRestaurantCoordinate)
        }
    }

    // Current region on map
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: -3.744126337359133,
            longitude: -38.53577978383463
        ),
        span: MKCoordinateSpan(latitudeDelta: 0.01,
                               longitudeDelta: 0.01))
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)

    // Show back button
    @Published var hiddeBackButton: Bool = false

    // Show bigger Image
    @Published var selectedImage: Bool = false

    // Variable catching error if occour
    @Published var localError: ErrorDescription?

    var currentRestaurantDishes: [DishModel]?

    init() {
        currentRestaurant = RestaurantModel(ckRestaurant: .init(recordName: ""))
    }

    func finishError() {
        localError = nil
    }

    func fetch() async {
        do {
            let newRestaurants = try await CloudKitRestaurantRepository().getRestaurants()
            DispatchQueue.main.async {
                self.restaurants = self.mapCKRestaurantsForRestaurantModel(ckRestaurants: newRestaurants)
            }
        }
        catch {
            if let receptedRrror = error as? CKError {
                DispatchQueue.main.async {
                    self.localError = CKErrorHandler.handleError(receptedRrror) as? ErrorDescription
                }
            }
        }
    }

    func mapCKRestaurantsForRestaurantModel(ckRestaurants: [RestaurantModel.cloudkit]) -> [RestaurantModel] {
        var restaurantList: [RestaurantModel] = []
        for ckRestaurant in ckRestaurants {
            let newRestaurant = RestaurantModel(ckRestaurant: ckRestaurant)
            if restaurantList.contains(newRestaurant) == false {
                restaurantList.append(newRestaurant)
            }
        }
        return restaurantList
    }

    private func fetchDishes() async {
        do {
            let restaurantDishes = try await CloudKitDishRepository().getDishesBy(
                restaurantRecordName: currentRestaurant.recordName)
            DispatchQueue.main.async {
                self.currentRestaurantDishes = self.mapCKDishesForDishModel(ckDishes: restaurantDishes)
            }
        }
        catch {
            if let receptedRrror = error as? CKError {
                DispatchQueue.main.async {
                    self.localError = CKErrorHandler.handleError(receptedRrror) as? ErrorDescription
                }
            }
        }
    }

    private func mapCKDishesForDishModel(ckDishes: [DishModel.cloudkit]) -> [DishModel] {
        var dishList: [DishModel] = []
        for ckDish in ckDishes {
            let newDish = DishModel(ckDish: ckDish)
            if dishList.contains(newDish) == false {
                dishList.append(newDish)
            }
        }
        return dishList
    }

    private func updateMapRegion(coordinate: CLLocationCoordinate2D) {
        withAnimation(.easeInOut) {
            DispatchQueue.main.async {
                self.mapRegion = MKCoordinateRegion(
                    center: coordinate,
                    span: self.mapSpan
                )
            }
        }
    }

    func showSelectedImage() {
        hiddeBackButton = true
        selectedImage = true
    }

    func hideSelectedImage() {
        selectedImage = false
        hiddeBackButton = false
    }

    func showNextRestaurant(newRestaurant: RestaurantModel) {
        withAnimation(.easeInOut) {
            DispatchQueue.main.async {
                withAnimation {
                    self.currentRestaurant = newRestaurant                    
                }
            }
        }
    }

    func nextButtonPressed() {
        guard restaurants.isEmpty == false else {
            return
        }

        guard let currentIndex = restaurants.firstIndex(where: {$0 == currentRestaurant}) else {
            return
        }

        let nextIndex = currentIndex + 1
        guard restaurants.indices.contains(nextIndex) else {
            let firstRestaurant = restaurants.first!
            showNextRestaurant(newRestaurant: firstRestaurant)
            return
        }

        let nextRestaurant = restaurants[nextIndex]
        showNextRestaurant(newRestaurant: nextRestaurant)
    }
}
