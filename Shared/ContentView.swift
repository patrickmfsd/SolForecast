//
//  ContentView.swift
//  Shared
//
//  Created by Patrick Mifsud on 15/6/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    var body: some View {
        ForecastView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
//            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
