//
//  AppTabView.swift
//  SolForecast
//
//  Created by Patrick Mifsud on 17/7/20.
//  Copyright © 2020 Patrick Mifsud. All rights reserved.
//

import SwiftUI
import SwiftData

import SwiftUI

struct AppTabView: View {
    @Binding var selection: AppScreen?
    
    var body: some View {
        TabView(selection: $selection) {
            ForEach(AppScreen.allCases) { screen in
                screen.destination
                    .tag(screen as AppScreen?)
                    .tabItem { screen.label }
            }
        }
    }
}

#Preview {
    AppTabView(selection: .constant(.forecast))
}
