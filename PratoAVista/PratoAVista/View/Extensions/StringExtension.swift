//
//  StringExtension.swift
//  PratoAVista
//
//  Created by Beatriz Leonel da Silva on 25/06/23.
//

import Foundation

extension String {
    func styleStringForFilter() -> Self {
        var new = self.lowercased()
        new = new.replacingOccurrences(of: "\n", with: " ")
        new = new.capitalizeWordsWithMoreThanTwoLetters()
        return new
    }

    func capitalizeWordsWithMoreThanTwoLetters() -> Self {
        let words = self.components(separatedBy: " ")
        let capitalizedWords = words.map { word -> String in
            if word.count > 2 {
                return word.capitalized
            } else {
                return word
            }
        }
        return capitalizedWords.joined(separator: " ")
    }

    func returnInBazilPriceStyle() -> Self {
        var parts = self.components(separatedBy: ".")
        if parts.count == 2 {
            if parts[1].count == 1 {
                parts[1].append("0")
            }
        }
        if parts.count == 1 {
            parts.append("00")
        }
        return parts.joined(separator: ",")
    }
}
