//
//  AIndexDetailView.swift
//  SolForecast
//
//  Created by Patrick Mifsud on 13/5/2024.
//

import SwiftUI

struct AIndexDetailView: View {
    @Environment(\.dismiss) var dismiss

    @StateObject var service = SWSRequestService()
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    VStack(alignment: .leading) {
                        Text("A Index")
                            .font(.headline)
                            .foregroundStyle(.secondary)
                        Text("\(service.aIndex?.index ?? "0")")
                            .font(.largeTitle)
                    }
                }
                Section {
                    RowView(label: "Valid Time", value: service.aIndex?.validTime ?? "-")
                }
                Section(header: Text("About A-Index").font(.headline)) {
                    Text(aIndexDesc)
                }
            }
            .background(.clear)
            .scrollContentBackground(.hidden)
            .listStyle(.insetGrouped)
            .navigationTitle("A Index")
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
                service.fetchSolarIndexes(req: .aIndex)
            }
            .refreshable {
                service.fetchSolarIndexes(req: .aIndex)
            }
        }
    }
}

#Preview {
    AIndexDetailView()
}
