//
//  DSTIndexDetailView.swift
//  SolForecast
//
//  Created by Patrick Mifsud on 17/5/2024.
//

import SwiftUI

struct DSTIndexDetailView: View {
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
                        Text("\(service.dstIndex?.index ?? "0")")
                            .font(.largeTitle)
                    }
                }
                Section {
                    RowView(label: "Valid Time", value: service.dstIndex?.validTime ?? "-")
                }
                Section(header: Text("About DST-Index").font(.headline)) {
                    Text(dstIndexDesc)
                }
            }
            .background(.clear)
            .scrollContentBackground(.hidden)
            .listStyle(.insetGrouped)
            .navigationTitle("DST Index")
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
                service.fetchSolarIndexes(req: .dstIndex)
            }
            .refreshable {
                service.fetchSolarIndexes(req: .dstIndex)
            }
        }
    }
}
#Preview {
    DSTIndexDetailView()
}
