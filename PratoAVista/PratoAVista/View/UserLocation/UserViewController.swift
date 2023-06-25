//
//  UserViewController.swift
//  PratoAVista
//
//  Created by Stephane Girão Linhares on 24/06/23.
//

import Foundation
import SwiftUI

class ViewController: UIViewController {

    // - Outlets
    @IBOutlet weak var locationLabel: UILabel!

    // - Constants
    private let locationManager = DeviceLocationService()

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let exposedLocation = self.locationManager.exposedLocation else {
            print("*** Error in \(#function): exposedLocation is nil")
            return
        }

        self.locationManager.getPlace(for: exposedLocation) { placemark in
            guard let placemark = placemark else { return }

            var output = "Our location is:"
            if let country = placemark.country {
                // swiftlint:disable: shorthand_operator
                output = output + "\n\(country)"
            }
            if let state = placemark.administrativeArea {
                output = output + "\n\(state)"
            }
            if let town = placemark.locality {
                output = output + "\n\(town)"
            }
            self.locationLabel.text = output
        }
    }
}
