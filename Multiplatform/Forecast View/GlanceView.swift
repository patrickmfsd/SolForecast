//
//  GlanceView.swift
//  SolForecast
//
//  Created by Patrick Mifsud on 17/5/2024.
//

import SwiftUI


struct GeoMagGlanceView: View {
    @StateObject var service = SWSRequestService()

    @State var glanceTapped: Bool = false
    
    var body: some View {
        GroupBox(label: Text("Geomagnetic Storms")) {
            HStack {
                if service.magAlert?.gScale == 0 {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("No events reported")
                            .font(.title3)
                            .foregroundStyle(.secondary)
                    }
                } else {
                    VStack(alignment: .leading, spacing: 5) {
                        Spacer()
                        Text("G\(service.magAlert?.gScale ?? 0)")
                            .font(.largeTitle)
                        Text("Until \(dateFromString(service.magAlert?.validUntil ?? "-").date.formatted(date: .abbreviated, time: .shortened))")
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
        .groupBoxStyle(
            ColorGroupBox(
                spacing: 15,
                radius: 20,
                level: service.magAlert?.gScale ?? 0
            ))
        .onTapGesture {
            if service.magAlert?.gScale != 0 {
                glanceTapped = true
            }
        }
        .sheet(isPresented: $glanceTapped) {
            MagDetailView()
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
        GlanceViewRow(
            title: "Example Title",
            value: "123",
            untilDate: "2024-05-17T10:00:00Z",
            destination: {
                Text("Destination View")
            }
        )
    }
}
