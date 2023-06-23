//
//  LocationViewModel.swift
//  PratoAVista
//
//  Created by Beatriz Leonel da Silva on 19/06/23.
//

import Foundation
import MapKit
import SwiftUI

class LocationsViewModel: ObservableObject {
    
    @Published var locations: [Location] // All loaded locations
    
    // Currente location map
    @Published var mapLocation: Location {
        didSet {
            updateMapRegion(location: mapLocation)
        }
    }
    
    // Current region on map
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    
    // Show list of locations
    @Published var showLocationsList: Bool = false
    
    // Show back button
    @Published var hiddeBackButton: Bool = false
    
    // Show bigger Image
    @Published var selectedImage: Bool = false
    
    init() {
        let locations = LocationsDataService.locations
        self.locations = locations
        self.mapLocation = locations.first!
        
        self.updateMapRegion(location: mapLocation)
    }
    
    func fetch() async {
        do {
            let restaurants = try await CloudKitRestaurantRepository().getRestaurants()
            print(restaurants.first)
            
        }
        catch {
            print(error)
        }
        //                    let dishes = try await CloudKitDishRepository().getDishesBy(restaurantRecordName: "7D625F3F-F68D-2A13-F7CB-A6DA33811E65")
    }
    
    private func updateMapRegion(location: Location) {
        withAnimation(.easeInOut) {
            mapRegion = MKCoordinateRegion(
                center: location.coordinates,
                span: mapSpan
            )
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
    
    func toggleLocationsList() {
        withAnimation(.easeInOut) {
            showLocationsList.toggle()
        }
    }
    
    func showNextLocation(location: Location) {
        withAnimation(.easeInOut) {
            mapLocation = location
        }
    }
    
    func nextButtonPressed() {
        guard locations.isEmpty == false else {
            return
        }
        
        guard let currentIndex = locations.firstIndex(where: {$0 == mapLocation}) else {
            return
        }
        
        //check if nextIndex is valid
        let nextIndex = currentIndex + 1
        guard locations.indices.contains(nextIndex) else {
            let firstLocation = locations.first!
            showNextLocation(location: firstLocation)
            return
        }
        
        let nextLocation = locations[nextIndex]
        showNextLocation(location: nextLocation)
    }
}
