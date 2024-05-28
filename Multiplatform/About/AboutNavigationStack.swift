//
//  AboutNavigationStack.swift
//  SolForecast
//
//  Created by Patrick Mifsud on 24/5/2024.
//

import SwiftUI
    
struct AboutNavigationStack: View {
    var body: some View {
        NavigationStack {
            AboutView()
                .navigationTitle("About")
        }
    }
}

#Preview {
    AboutNavigationStack()
}
