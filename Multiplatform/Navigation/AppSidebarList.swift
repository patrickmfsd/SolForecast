//
//  AppSidebarList.swift
//  SolForecast
//
//  Created by Patrick Mifsud on 25/6/20.
//

import SwiftUI
import SwiftData

struct AppSidebarList: View {
    @Binding var selection: AppScreen?
    
    let appName = Bundle.main.infoDictionary?["CFBundleName"] as? String
        
    var body: some View {
        List(selection: $selection) {
            ForEach(AppScreen.allCases) { screen in
                NavigationLink(value: screen) {
                    screen.label
                }
            }
        }
        .navigationTitle("\(appName ?? "")")
    }
}

#Preview {
    NavigationSplitView {
        AppSidebarList(selection: .constant(.forecast))
    } detail: {
        Text(verbatim: "Check out that sidebar!")
    }
//    .backyardBirdsDataContainer(inMemory: true)
}



