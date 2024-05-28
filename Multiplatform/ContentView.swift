//
//  ContentView.swift
//  SolForecast
//
//  Created by Patrick Mifsud on 15/6/21.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: AppScreen? = .forecast
    
    @Environment(\.prefersTabNavigation) private var prefersTabNavigation
    
    var body: some View {
        if prefersTabNavigation {
            AppTabView(selection: $selection)
        } else {
            NavigationSplitView {
                AppSidebarList(selection: $selection)
            } detail: {
                AppDetailColumn(screen: selection)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
