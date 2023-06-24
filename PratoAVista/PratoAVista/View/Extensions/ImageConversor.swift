//
//  ImageConversor.swift
//  PratoAVista
//
//  Created by Beatriz Leonel da Silva on 23/06/23.
//

import Foundation
import SwiftUI
import CloudKit

extension View {
    func convertToUIImage(ckAsset: CKAsset) -> UIImage? {
        var newUiImage: UIImage? = nil
        if let imageData = try? Data(contentsOf: ckAsset.fileURL!), let uiImage = UIImage(data: imageData) {
            newUiImage = uiImage
        }
        return newUiImage
    }
}

