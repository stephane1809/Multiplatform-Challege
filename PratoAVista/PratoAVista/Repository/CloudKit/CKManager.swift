//
//  CKManager.swift
//  PratoAVista
//
//  Created by Lais Godinho on 21/06/23.
//

import Foundation
import CloudKit

class CKManager {
    static let shared = CKManager()

    let container: CKContainer
    let publicDatabase: CKDatabase

    private init() {
        container = CKContainer(identifier: "iCloud.br.com.PratoAVista")
        publicDatabase = container.publicCloudDatabase
    }
}
