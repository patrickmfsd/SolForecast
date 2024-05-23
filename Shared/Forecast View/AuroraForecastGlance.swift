//
//  AuroraForecastGlance.swift
//  SolForecast
//
//  Created by Patrick Mifsud on 16/5/2024.
//

import SwiftUI

struct AuroraForecastGlance: View {
    @StateObject var viewModel = SWSRequestService()
    
    var body: some View {
        NavigationLink(destination: AuroraDetailView()) {
            GroupBox(label: Text("Aurora Forecast")) {
                VStack(alignment: .leading) {
                    Text("Next 48 Hours")
                        .font(.subheadline)
                        .fontWeight(.medium)
                    Spacer()
                    if let auroraWatch = viewModel.auroraWatch {
                        Text("K-\(auroraWatch.cause)")
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
                    Spacer()
                    Divider()
                    Text("Next 3 - 7 Days")
                        .font(.subheadline)
                        .fontWeight(.medium)
                    Spacer()
                    if let auroraOutlook = viewModel.auroraOutlook {
                        Text("K-\(auroraOutlook.cause)")
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
                    Spacer()
                }
                .foregroundColor(.primary)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 250)
            .onAppear {
                viewModel.fetchAlerts(alertType: .auroraOutlook)
            }
            
        }
    }
}

#Preview {
    AuroraForecastGlance()
}
