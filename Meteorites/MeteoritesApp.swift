//
//  MeteoritesApp.swift
//  Meteorites
//
//  Created by Kateřina Černá on 10.11.2022.
//

import SwiftUI

@main
struct MeteoritesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MapView()
        }
    }
}
