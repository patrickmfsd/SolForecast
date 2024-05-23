//
//  KIndexDetailView.swift
//  SolForecast
//
//  Created by Patrick Mifsud on 17/5/2024.
//

import SwiftUI

struct KIndexDetailView: View {
    @Environment(\.dismiss) var dismiss

    @StateObject var service = SWSRequestService()
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    VStack(alignment: .leading) {
                        Text("K Index")
                            .font(.headline)
                            .foregroundStyle(.secondary)
                        Text("\(service.kIndex?.index ?? 0)")
                            .font(.largeTitle)
                    }
                }
                Section {
                    RowView(label: "Valid Time", value: service.kIndex?.validTime ?? "-")
                }
                Section(header: Text("About K-Index").font(.headline)) {
                    Text(kIndexDesc)
                }
            }
            .background(.clear)
            .scrollContentBackground(.hidden)
            .listStyle(.insetGrouped)
            .navigationTitle("K Index")
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
                service.fetchSolarIndexes(req: .kIndex)
            }
            .refreshable {
                service.fetchSolarIndexes(req: .kIndex)
            }
        }
    }
}

#Preview {
    KIndexDetailView()
}
