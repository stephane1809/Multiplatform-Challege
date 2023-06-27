//
//  MenuViewModel.swift
//  PratoAVista
//
//  Created by Beatriz Leonel da Silva on 25/06/23.
//

import Foundation
import CloudKit

class MenuViewModel: ObservableObject {
    let restaurant: RestaurantModel
    let dishes: [DishModel]
    @Published var categorys: [String] = [] {
        didSet {
            if let firstCategory = categorys.first {
                currentCategory = firstCategory
            }
        }
    }
    @Published var currentCategory: String = "" {
        didSet {
            getCurrentCategoryDishes()
        }
    }
    @Published var currentDishes: [DishModel] = []
    @Published var selectedDish: DishModel?
    @Published var showDish = false
    @Published var saveAlert: Bool = false

    init(restaurant: RestaurantModel, dishes: [DishModel]) {
        self.restaurant = restaurant
        self.dishes = dishes
    }

    func getAllCategorys() {
        for dish in dishes {
            if let category = dish.category?.styleStringForFilter() {
                if categorys.contains(category) == false {
                    self.categorys.append(category)
                }
            }
        }
    }

    func returnNextCategory() -> String {
        guard let currentIndex = categorys.firstIndex(of: currentCategory) else { return currentCategory }

        let nextIndex = currentIndex + 1
        guard categorys.indices.contains(nextIndex) else { return currentCategory }

        let nextCategory = categorys[nextIndex]
        return nextCategory
    }

    func returnBackCategory() -> String {
        guard let currentIndex = categorys.firstIndex(of: currentCategory) else { return currentCategory }

        let nextIndex = currentIndex - 1
        guard categorys.indices.contains(nextIndex) else { return currentCategory }

        let nextCategory = categorys[nextIndex]
        return nextCategory
    }

    func updateCategory(_ newCategory: String) {
        currentCategory = newCategory
    }

    func getCurrentCategoryDishes() {
        currentDishes = self.dishes.filter({ $0.category?.styleStringForFilter() == currentCategory })
    }
}
