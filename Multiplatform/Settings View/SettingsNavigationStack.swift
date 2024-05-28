//
//  SettingsNavigationStack.swift
//  SolForecast
//
//  Created by Patrick Mifsud on 24/5/2024.
//

import SwiftUI

struct SettingsNavigationStack: View {
    var body: some View {
        NavigationStack {
            SettingsView()
                .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsNavigationStack()
}
