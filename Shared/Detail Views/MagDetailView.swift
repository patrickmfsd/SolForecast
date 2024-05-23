//
//  MagDetailView.swift
//  SolForecast
//
//  Created by Patrick Mifsud on 13/5/2024.
//

import SwiftUI

struct MagDetailView: View {
    @Environment(\.dismiss) var dismiss

    @StateObject var service = SWSRequestService()
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Current Storm").font(.headline)) {
                    VStack(alignment: .leading) {
                        Text("Level")
                            .font(.headline)
                            .foregroundStyle(.secondary)
                        Text("G\(service.magAlert?.gScale ?? 0)")
                            .font(.largeTitle)
                    }
                    Text(service.magAlert?.description.capitalized ?? "No Magnetic Event reported")
                }.listRowBackground(Color.red)
                if "\(String(describing: service.magAlert?.gScale))".isEmpty {
                    Section {
                        RowView(label: "Start Time", value: service.magAlert?.startTime ?? "")
                        RowView(label: "Valid Till", value: service.magAlert?.validUntil ?? "")
                    }
                }
                if service.magAlert?.gScale ?? 0 >= 1 {
                    Section(header: Text("Current Geophysical Warning").font(.headline)) {
                        VStack(alignment: .leading) {
                            Text("Warning Cause")
                                .font(.footnote)
                                .foregroundStyle(.secondary)
                            Text(service.magWarning?.cause.capitalized ?? "")
                        }
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Start")
                                    .font(.footnote)
                                    .foregroundStyle(.secondary)
                                Text("\(service.magWarning?.startDate ?? "-")")
                            }
                            Spacer()
                            VStack(alignment: .trailing) {
                                Text("End")
                                    .font(.footnote)
                                    .foregroundStyle(.secondary)
                                Text("\(service.magWarning?.endDate ?? "-")")
                            }
                        }
                        RowView(label: "Issue Time", value: "\(service.magWarning?.issueTime ?? "-")")
                    }
                    Section(header: Text("Comments").font(.headline)) {
                        Text(service.magWarning?.comments ?? "No Comments")
                    }
                }
                Section(header: Text("Forecast").font(.headline)) {
                    if let magWarning = service.magWarning {
                        ForEach(magWarning.magWarningActivity,  id: \.date) { act in
                            VStack(alignment: .leading) {
                                Text(act.date)
                                Text(act.forecast.capitalized)
                            }
                        }
                    } else {
                        Text("No Magnetic Events Forecasted.")
                    }
                }
            }
            .background(.clear)
            .scrollContentBackground(.hidden)
            .listStyle(.insetGrouped)
            .navigationTitle("Geomagnetic Storms")
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
                                .foregroundStyle(.black)
                        }
                }
            }
            .onAppear {
                service.fetchAlerts(alertType: .magAlert)
                service.fetchAlerts(alertType: .magWarning)
                
            }
            .refreshable {
                service.fetchAlerts(alertType: .magAlert)
                service.fetchAlerts(alertType: .magWarning)
                
            }
        }
    }
}

struct MagDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MagDetailView()
    }
}
