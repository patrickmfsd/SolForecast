//
//  AuroraDetailView.swift
//  SolForecast
//
//  Created by Patrick Mifsud on 13/5/2024.
//

import SwiftUI

struct AuroraDetailView: View {
    @Environment(\.dismiss) var dismiss

    @StateObject var service = SWSRequestService()

    var body: some View {
        NavigationView {
            List {
                // Current Aurora Forecast
                Section(header: Text("Current").font(.headline)) {
                    VStack(alignment: .leading) {
                        Text("K Index")
                            .font(.headline)
                            .foregroundStyle(.secondary)
                        Text("\(String(describing: service.auroraAlert?.kAus))")
                            .font(.largeTitle)
                    }
                    RowView(label: "Visibility", value: service.auroraAlert?.latBand.capitalized ?? "-")
                    RowView(label: "Start Time", value: service.auroraAlert?.startTime ?? "-")
                    RowView(label: "Valid Till", value: service.auroraAlert?.validUntil ?? "-")
                    Text(service.auroraAlert?.description.capitalized ?? "No Description")
                }
                
                    // Aurora Watch - Next 48HR
                Section(header: Text("Next 48HR").font(.headline)) {
                    VStack(alignment: .leading) {
                        Text("K Index")
                            .font(.headline)
                            .foregroundStyle(.secondary)
                        Text("\(String(describing: service.auroraWatch?.kAus))")
                            .font(.largeTitle)
                        Text(service.auroraWatch?.latBand.capitalized ?? "")
                        Text(service.auroraWatch?.cause.capitalized ?? "")
                    }
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Start")
                                .font(.footnote)
                                .foregroundStyle(.secondary)
                            Text("\(service.auroraWatch?.startDate ?? "-")")
                        }
                        Spacer()
                        VStack(alignment: .trailing) {
                            Text("End")
                                .font(.footnote)
                                .foregroundStyle(.secondary)
                            Text("\(service.auroraWatch?.endDate ?? "-")")
                        }
                    }
                    RowView(label: "Issue Time", value: "\(service.auroraWatch?.issueTime ?? "-")")
                    Text(service.auroraWatch?.comments ?? "No Comments")
                }
                
                    // Aurora Outlook - Next 3 - 7 Days
                Section(header: Text("Next 3 - 7 Days").font(.headline)) {
                    VStack(alignment: .leading) {
                        Text("K Index")
                            .font(.headline)
                            .foregroundStyle(.secondary)
                        Text("\(String(describing: service.auroraOutlook?.kAus))")
                            .font(.largeTitle)
                        Text(service.auroraOutlook?.latBand.capitalized ?? "")
                        Text(service.auroraOutlook?.cause.capitalized ?? "")
                    }
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Start")
                                .font(.footnote)
                                .foregroundStyle(.secondary)
                            Text("\(service.auroraOutlook?.startDate ?? "-")")
                        }
                        Spacer()
                        VStack(alignment: .trailing) {
                            Text("End")
                                .font(.footnote)
                                .foregroundStyle(.secondary)
                            Text("\(service.auroraOutlook?.endDate ?? "-")")
                        }
                    }
                    RowView(label: "Issue Time", value: "\(service.auroraOutlook?.issueTime ?? "-")")
                    Text(service.auroraOutlook?.comments ?? "No Comments")
                }
                
                    // Infomation
                Section(header: Text("About Aurora Alerts").font(.headline)) {
                    Text(auroraDesc)
                }
                Section(header: Text("About K-Index").font(.headline)) {
                    Text(kIndexDesc)
                }
            }
            .background(.clear)
            .scrollContentBackground(.hidden)
            .onAppear {
                service.fetchAlerts(alertType: .auroraAlert)
                service.fetchAlerts(alertType: .auroraWatch)
                service.fetchAlerts(alertType: .auroraOutlook)
            }
            .refreshable {
                service.fetchAlerts(alertType: .auroraAlert)
                service.fetchAlerts(alertType: .auroraWatch)
                service.fetchAlerts(alertType: .auroraOutlook)
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Aurora Forecast")
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Button(
                        role: .cancel,
                        action: {
                            dismiss()
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .symbolRenderingMode(.hierarchical)
                                .font(.title3)
                                .foregroundStyle(.primary)
                        }
                }
            }
        }
    }
}

struct AuroraDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AuroraDetailView()
    }
}

