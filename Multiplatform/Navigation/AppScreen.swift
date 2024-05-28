//
//  AppScreen.swift
//  SolForecast
//
//  Created by Patrick Mifsud on 9/4/2024.
//  Copyright © 2024 Patrick Mifsud. All rights reserved.
//

import SwiftUI

enum AppScreen: Codable, Hashable, Identifiable, CaseIterable {
    case forecast
    /// The value for the ``About``.
//    case about
   /// The value for the ``SettingsView``.
    case settings
    
    var id: AppScreen { self }
}

extension AppScreen {
    @ViewBuilder
    var label: some View {
        switch self {
            case .forecast:
                Label("Forecast", systemImage: "calendar")
//            case .about:
//                Label("About", systemImage: "info")
            case .settings:
                Label("Settings", systemImage: "gear")
        }
    }
    
    @ViewBuilder
    var destination: some View {
        switch self {
            case .forecast:
                ForecastNavigationStack()
//            case .about:
//                AboutNavigationStack()
            case .settings:
                SettingsNavigationStack()
        }
    }
}
