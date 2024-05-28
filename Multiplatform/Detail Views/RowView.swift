//
//  RowView.swift
//  SolForecast
//
//  Created by Patrick Mifsud on 13/5/2024.
//

import SwiftUI

struct RowView: View {
    var label: String
    var value: String
    
    var body: some View {
        HStack {
            Text(label)
                .foregroundStyle(.secondary)
            Spacer()
            Text(value)
        }
    }
}

#Preview {
    RowView(label: "Placeholder", value: "Desc")
}
