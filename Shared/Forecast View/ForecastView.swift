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
        NavigationView {
            VStack {
                Text("Solar Forecast")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .fontDesign(.monospaced)
                    .foregroundStyle(.white)
                ScrollView {
                    HStack {
                        GlanceView(
                            title: "Aurora",
                            value: service.auroraAlert?.kAus ?? 0,
                            untilDate: service.auroraAlert?.validUntil ?? "-",
                            destination: { AuroraDetailView() }
                        )
                        GlanceView(
                            title: "Geomagnetic Storms",
                            value: service.magAlert?.gScale ?? 0,
                            untilDate: service.magAlert?.validUntil ?? "-",
                            destination: { MagDetailView() }
                        )
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
                    .groupBoxStyle(MaterialGroupBox(spacing: 10, radius: 25, material: .thin))
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
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button(
                        action: {
                                // Action
                            let impactMed = UIImpactFeedbackGenerator(style: .medium)
                            impactMed.impactOccurred()
                        },
                        label: {
                            Image(systemName: "switch.2")
                                .font(.title2)
                                .symbolRenderingMode(.hierarchical)
                                .foregroundColor(.white)
                        }
                    )
                }
            }
            .background {
                switch service.magAlert?.gScale {
                    case 0:
                        LinearGradient(gradient: Gradient(stops: [
                            .init(color: .gray, location: 0.40),
                            .init(color: .teal, location: 0.90)
                        ]), startPoint: .top, endPoint: .bottom)
                        .ignoresSafeArea()
                    case 1:
                        LinearGradient(gradient: Gradient(stops: [
                            .init(color: .teal, location: 0.40),
                            .init(color: .purple, location: 0.90)
                        ]), startPoint: .top, endPoint: .bottom)
                        .ignoresSafeArea()
                    case 2:
                        LinearGradient(gradient: Gradient(stops: [
                            .init(color: .purple, location: 0.40),
                            .init(color: .yellow, location: 0.90)
                        ]), startPoint: .top, endPoint: .bottom)
                        .ignoresSafeArea()
                    case 3:
                        LinearGradient(gradient: Gradient(stops: [
                            .init(color: .yellow, location: 0.40),
                            .init(color: .orange, location: 0.90)
                        ]), startPoint: .top, endPoint: .bottom)
                        .ignoresSafeArea()
                    case 4:
                        LinearGradient(gradient: Gradient(stops: [
                            .init(color: .orange, location: 0.40),
                            .init(color: .red, location: 0.90)
                        ]), startPoint: .top, endPoint: .bottom)
                        .ignoresSafeArea()
                    case 5:
                        LinearGradient(gradient: Gradient(stops: [
                            .init(color: .red, location: 0.70),
                            .init(color: .orange, location: 0.90)
                        ]), startPoint: .top, endPoint: .bottom)
                        .ignoresSafeArea()
                    case .none, .some(_):
                        Color.secondary
                            .ignoresSafeArea()
                }
            }
        }
        
        
    }
}

#Preview {
    ForecastView()
}
