//
//  DishManager.swift
//  PratoAVista
//
//  Created by Lais Godinho on 25/06/23.
//

import Foundation
import CloudKit

class DishManager {
    let ckDishRepository = CloudKitDishRepository()
    let ckAlergenicRepository = CloudKitAlergenicRepository()

    func getDishesBy(restaurantRecordName: String) async -> [Dish] {
        let ckDishes = await ckDishRepository.getDishesBy(restaurantRecordName: restaurantRecordName)

        var dishes: [Dish] = []
        for ckDish in ckDishes {
            var alergenics: [String] = []

            for alergenicReference in ckDish.alergenics {
                let ckAlergenics = await ckAlergenicRepository.getAlergenicBy(recordReference: alergenicReference)

                if ckAlergenics.count <= 0 {
                    fatalError("No alergenic with record reference \(alergenicReference)")
                }

                guard let type = ckAlergenics[0].type else {
                    fatalError("No alergenic type")
                }
                alergenics.append(type)
            }

            dishes.append(ckDishRepository.parseCKDishToDish(ckDish: ckDish, alergenics: alergenics))
        }

        return dishes
    }

    func getDishBy(recordName: String) async -> Dish {
        let ckDishes = await ckDishRepository.getDishBy(recordName: recordName)

        if ckDishes.count == 0 {
            fatalError("No dishes found with recordName \(recordName)")
        }

        let ckDish = ckDishes[0]

        var alergenics: [String] = []

        for alergenicReference in ckDish.alergenics {
            let ckAlergenics = await ckAlergenicRepository.getAlergenicBy(recordReference: alergenicReference)

            if ckAlergenics.count <= 0 {
                fatalError("No alergenic with record reference \(alergenicReference)")
            }

            guard let type = ckAlergenics[0].type else {
                fatalError("No alergenic type")
            }
            alergenics.append(type)
        }

        let dish = ckDishRepository.parseCKDishToDish(ckDish: ckDish, alergenics: alergenics)


        return dish
    }
}
