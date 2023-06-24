//
//  OrientationDetector.swift
//  PratoAVista
//
//  Created by Beatriz Leonel da Silva on 22/06/23.
//

import Foundation
import SwiftUI

struct OrientationDetector: ViewModifier {
    let action: (UIDeviceOrientation) -> Void

    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                action(UIDevice.current.orientation)
            }
    }
}

extension View {
    func onRotate(perform action: @escaping (UIDeviceOrientation) -> Void) -> some View {
        self.modifier(OrientationDetector(action: action))
    }
}
