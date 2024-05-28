//
//  AuroraForecastGlance.swift
//  SolForecast
//
//  Created by Patrick Mifsud on 16/5/2024.
//

import SwiftUI

struct AuroraForecastGlance: View {
    @StateObject var service = SWSRequestService()
    @State var glanceTapped: Bool = false
    
    var body: some View {
        GroupBox(label: Text("Aurora Forecast")) {
            VStack {
                GroupBox {
                    HStack {
                        if service.auroraAlert?.kAus == 0 {
                            VStack(alignment: .leading, spacing: 5) {
                                Text("No events reported")
                                    .font(.title3)
                                    .foregroundStyle(.secondary)
                            }
                        } else {
                            VStack(alignment: .leading, spacing: 5) {
                                Spacer()
                                Text("K\(service.auroraAlert?.kAus ?? 0)")
                                    .font(.largeTitle)
                                Text("Until \(dateFromString(service.auroraAlert?.validUntil ?? "-").date.formatted(date: .abbreviated, time: .shortened))")
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
                .groupBoxStyle(MaterialGroupBox(spacing: 15, radius: 20, material: .ultraThin))
                HStack {
                    VStack(alignment: .leading) {
                        Text("Next 48 Hours")
                            .font(.subheadline)
                            .fontWeight(.medium)
                        if let auroraWatch = service.auroraWatch {
                            Text("K\(auroraWatch.cause)")
                                .font(.largeTitle)
                            Text(auroraWatch.latBand.capitalized)
                            Spacer()
                            Text("Until \(dateFromString(auroraWatch.endDate).date.formatted(date: .abbreviated, time: .shortened))")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        } else {
                            Text("No outlook available")
                                .multilineTextAlignment(.leading)
                                .foregroundColor(.secondary)
                        }
                    }
                    Spacer()
                    Divider()
                    VStack(alignment: .leading) {
                        Text("Next 3 - 7 Days")
                            .font(.subheadline)
                            .fontWeight(.medium)
                        if let auroraOutlook = service.auroraOutlook {
                            Text("K\(auroraOutlook.cause)")
                                .font(.largeTitle)
                            Text(auroraOutlook.latBand.capitalized)
                            Spacer()
                            Text("Until \(dateFromString(auroraOutlook.endDate).date.formatted(date: .abbreviated, time: .shortened))")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        } else {
                            Text("No outlook available")
                                .multilineTextAlignment(.leading)
                                .foregroundColor(.secondary)
                        }
                    }
                    Spacer()
                }
                .foregroundColor(.primary)
            }
        }
        .groupBoxStyle(MaterialGroupBox(spacing: 15, radius: 25, material: .thick))
        .frame(maxWidth: .infinity)
        .frame(height: 250)
        .onAppear {
            service.fetchAlerts(alertType: .auroraAlert)
            service.fetchAlerts(alertType: .auroraWatch)
            service.fetchAlerts(alertType: .auroraOutlook)
        }
        .onTapGesture {
            glanceTapped = true
        }
        .sheet(isPresented: $glanceTapped) {
            AuroraDetailView()
                .presentationCornerRadius(20)
                .presentationBackground(.regularMaterial)
                .presentationDragIndicator(.visible)
        }
    }
}

#Preview {
    AuroraForecastGlance()
}
