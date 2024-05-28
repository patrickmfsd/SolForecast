//
//  ForecastNavigationView.swift
//  SolForecast
//
//  Created by Patrick Mifsud on 24/5/2024.
//

import SwiftUI

struct ForecastNavigationStack: View {
    var body: some View {
        NavigationStack {
            ForecastView()
                .navigationTitle("Solar Forecast")
        }
    }
}

#Preview {
    ForecastNavigationStack()
}
