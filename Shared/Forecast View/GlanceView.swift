//
//  GlanceView.swift
//  SolForecast
//
//  Created by Patrick Mifsud on 17/5/2024.
//

import SwiftUI

struct GlanceView<Destination: View>: View {
    var title: String = "-"
    var value: Int = 0
    var untilDate: String = "-"
    var destination: () -> Destination
    
    @State var glanceTapped: Bool = false
    
    var body: some View {
        GroupBox {
            HStack {
                if value == 0 {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("No events reported")
                            .font(.title3)
                            .foregroundStyle(.secondary)
                        Text(title)
                            .font(.headline)
                    }
                } else {
                    VStack(alignment: .leading, spacing: 5) {
                        Spacer()
                        Text("\(value)")
                            .font(.largeTitle)
                        Text(title)
                            .font(.headline)
                        Text("Until \(dateFromString(untilDate).date.formatted(date: .abbreviated, time: .shortened))")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        Spacer()
                    }
                    .foregroundColor(.primary)
                }
                Spacer()
            }
            .frame(height: 100)
        }
        .groupBoxStyle(MaterialGroupBox(spacing: 15, radius: 20, material: .thin))
        .onTapGesture {
            if value != 0 {
                glanceTapped = true
            }
        }
        .sheet(isPresented: $glanceTapped) {
            destination()
                .presentationCornerRadius(20)
                .presentationBackground(.regularMaterial)
                .presentationDragIndicator(.visible)
        }
    }
}

struct GlanceViewRow<Destination: View>: View {
    var title: String = "-"
    var value: String = "-"
    var untilDate: String = "-"
    var destination: () -> Destination
    
    @State var glanceTapped: Bool = false
    
    var body: some View {
        GroupBox {
            HStack {
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.headline)
                    Text("Until \(dateFromString(untilDate).date.formatted(date: .abbreviated, time: .shortened))")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                Spacer()
                Text(value)
                    .font(.largeTitle)
            }
            .foregroundColor(.primary)
        }
        .groupBoxStyle(MaterialGroupBox(spacing: 15, radius: 20, material: .ultraThin))
        .onTapGesture {
            glanceTapped = true
        }
        .sheet(isPresented: $glanceTapped) {
            destination()
                .presentationCornerRadius(20)
                .presentationBackground(.regularMaterial)
                .presentationDragIndicator(.visible)
        }
    }
}


#Preview {
    NavigationView {
        GlanceView(
            title: "Example Title",
            value: 123,
            untilDate: "2024-05-17T10:00:00Z",
            destination: {
                Text("Destination View")
            }
        )
    }
}
