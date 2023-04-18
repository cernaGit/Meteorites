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
                TabView {
                    MapView()
                        .tabItem {
                            Label("Map", systemImage: "map.fill")
                                .foregroundColor(.red)
                        }

                    MeteoritesListView()
                        .tabItem {
                            Label("List", systemImage: "list.dash")
                        }
                }.background(.black)
            .onAppear() {
                UITabBar.appearance().backgroundColor = .white
            }.accentColor(.black).toolbarColorScheme(.dark)

        }
    }
}
