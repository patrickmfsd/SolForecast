//
//  ForecastView.swift
//  SolForecast
//
//  Created by Patrick Mifsud on 13/5/2024.
//

import SwiftUI

struct ForecastView: View {
    @StateObject var service = SWSRequestService()
    
    var body: some View {
        ScrollView {
            VStack {
                GeoMagGlanceView()
                AuroraForecastGlance()
            }
            GroupBox {
                VStack {
                    GlanceViewRow(
                        title: "A Index",
                        value: "\(service.aIndex?.index ?? "0")",
                        untilDate: service.aIndex?.validTime ?? "-",
                        destination: { AIndexDetailView() }
                    )
                    GlanceViewRow(
                        title: "K Index",
                        value: "\(service.kIndex?.index ?? 0)",
                        untilDate: service.kIndex?.validTime ?? "-",
                        destination: { KIndexDetailView() }
                    )
                    GlanceViewRow(
                        title: "DST Index",
                        value: "\(service.dstIndex?.index ?? "0")",
                        untilDate: service.dstIndex?.validTime ?? "-",
                        destination: { DSTIndexDetailView() }
                    )
                }
            }
            .groupBoxStyle(MaterialGroupBox(spacing: 10, radius: 25, material: .regular))
        }
        .padding(.horizontal)
        .onAppear {
            service.fetchAlerts(alertType: .auroraAlert)
            service.fetchAlerts(alertType: .auroraWatch)
            service.fetchAlerts(alertType: .auroraOutlook)
            service.fetchAlerts(alertType: .magAlert)
            service.fetchAlerts(alertType: .magWarning)
            service.fetchSolarIndexes(req: .aIndex)
            service.fetchSolarIndexes(req: .dstIndex)
            service.fetchSolarIndexes(req: .kIndex)
        }
        .refreshable {
            print("refresh")
            service.fetchAlerts(alertType: .auroraAlert)
            service.fetchAlerts(alertType: .auroraWatch)
            service.fetchAlerts(alertType: .auroraOutlook)
            service.fetchAlerts(alertType: .magAlert)
            service.fetchAlerts(alertType: .magWarning)
            service.fetchSolarIndexes(req: .aIndex)
            service.fetchSolarIndexes(req: .dstIndex)
            service.fetchSolarIndexes(req: .kIndex)
        }
    }
}

#Preview {
    ForecastView()
}
