//
//  DishTags.swift
//  PratoAVista
//
//  Created by Beatriz Leonel da Silva on 21/06/23.
//

import Foundation

enum DishTag {
    case wheat
    case lactose
    case pig
    case egg
    case fish
    case crustacean
    case peanut
    case celery
    case soya
    case castanha
    
    var label: String {
        switch self {
        case .wheat:
            return "Trigo"
        case .lactose:
            return "Lactose"
        case .pig:
            return "Porco"
        case .egg:
            return "Ovo"
        case .fish:
            return "Peixe"
        case .crustacean:
            return "Crustáceo"
        case .peanut:
            return "Amendoim"
        case .castanha:
            return "Castanha"
        case .celery:
            return "Aipo"
        case .soya:
            return "Soja"
        }
    }

    var icon: String {
        switch self {
        case .wheat:
            return "wheat"
        case .lactose:
            return "milk"
        case .pig:
            return "pig"
        case .egg:
            return "egg"
        case .fish:
            return "fish"
        case .crustacean:
            return "crustacean"
        case .peanut, .castanha:
            return "peanut"
        case .celery:
            return "celery"
        case .soya:
            return "soya"
        }
    }
}
