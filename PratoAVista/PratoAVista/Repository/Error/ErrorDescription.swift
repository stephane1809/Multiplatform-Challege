//
//  ErrorDescription.swift
//  PratoAVista
//
//  Created by Beatriz Leonel da Silva on 23/06/23.
//

import Foundation

struct ErrorDescription: LocalizedError, CustomStringConvertible {
    let localizedDescription: String
    let recoverySuggestion: String?
    
    var description: String {  return
        "\(localizedDescription) \(recoverySuggestion ?? "")"
    }
    
    init(localizedDescription: String, recoverySuggestion: String? = nil) {
        self.localizedDescription = localizedDescription
        self.recoverySuggestion = recoverySuggestion
    }
}
