//
//  SolForecastApp.swift
//  Shared
//
//  Created by Patrick Mifsud on 15/6/21.
//

import SwiftUI

@main
struct SolForecastApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
