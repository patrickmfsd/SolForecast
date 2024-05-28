//
//  Helper.swift
//  SolForecast
//
//  Created by Patrick Mifsud on 13/5/2024.
//

import Foundation
import SwiftUI

//MARK: - Prefers Tab Navigation
struct PrefersTabNavigationEnvironmentKey: EnvironmentKey {
    static var defaultValue: Bool = false
}

extension EnvironmentValues {
    var prefersTabNavigation: Bool {
        get { self[PrefersTabNavigationEnvironmentKey.self] }
        set { self[PrefersTabNavigationEnvironmentKey.self] = newValue }
    }
}

#if os(iOS)
extension PrefersTabNavigationEnvironmentKey: UITraitBridgedEnvironmentKey {
    static func read(from traitCollection: UITraitCollection) -> Bool {
        return traitCollection.userInterfaceIdiom == .phone || traitCollection.userInterfaceIdiom == .tv
    }
    
    static func write(to mutableTraits: inout UIMutableTraits, value: Bool) {
            // Do not write.
    }
}
#endif

//MARK: - Material Group box
struct MaterialGroupBox: GroupBoxStyle {
    var spacing: CGFloat
    var radius: CGFloat
    var material: Material
    
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading) {
            configuration.label
                .font(.headline)
            configuration.content
        }
        .padding(spacing)
        .background(material, in: RoundedRectangle(cornerRadius: radius, style: .continuous))
    }
}

struct ColorGroupBox: GroupBoxStyle {
    var spacing: CGFloat
    var radius: CGFloat
    var level: Int
    
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading) {
            configuration.label
                .font(.headline)
            configuration.content
        }
        .padding(spacing)
        .background {
            switch level {
                case 0:
                    LinearGradient(gradient: Gradient(stops: [
                        .init(color: .gray.opacity(0.2), location: 0.40),
                        .init(color: .gray.opacity(0.3), location: 0.90)
                    ]), startPoint: .topLeading, endPoint: .bottomTrailing)
                case 1:
                    LinearGradient(gradient: Gradient(stops: [
                        .init(color: .teal, location: 0.40),
                        .init(color: .purple, location: 0.90)
                    ]), startPoint: .topLeading, endPoint: .bottomTrailing)
                case 2:
                    LinearGradient(gradient: Gradient(stops: [
                        .init(color: .purple, location: 0.40),
                        .init(color: .yellow, location: 0.90)
                    ]), startPoint: .topLeading, endPoint: .bottomTrailing)
                case 3:
                    LinearGradient(gradient: Gradient(stops: [
                        .init(color: .yellow, location: 0.40),
                        .init(color: .orange, location: 0.90)
                    ]), startPoint: .topLeading, endPoint: .bottomTrailing)
                case 4:
                    LinearGradient(gradient: Gradient(stops: [
                        .init(color: .orange, location: 0.40),
                        .init(color: .red, location: 0.90)
                    ]), startPoint: .topLeading, endPoint: .bottomTrailing)
                case 5:
                    LinearGradient(gradient: Gradient(stops: [
                        .init(color: .red, location: 0.70),
                        .init(color: .orange, location: 0.90)
                    ]), startPoint: .topLeading, endPoint: .bottomTrailing)
                default:
                    Color.gray.opacity(0.2)  
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: radius))
    }
}

// MARK: - Date From String
func dateFromString(_ dateString: String) -> (date: Date, formattedString: String) {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US_POSIX") // Set locale to ensure correct date parsing
    dateFormatter.timeZone = TimeZone(secondsFromGMT: 0) // Set time zone to UTC or your desired time zone
    
        // Attempt to parse with yyyy-MM-dd HH:mm:ss format
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    if let date = dateFormatter.date(from: dateString) {
        let formattedString = dateFormatter.string(from: date)
        return (date, formattedString)
    }
    
        // Attempt to parse with yyyy-MM-dd format
    dateFormatter.dateFormat = "yyyy-MM-dd"
    if let date = dateFormatter.date(from: dateString) {
        let formattedString = dateFormatter.string(from: date)
        return (date, formattedString)
    }
    
        // If both attempts fail, return the current date and the original string
    let currentDate = Date()
    let formattedCurrentDate = dateFormatter.string(from: currentDate)
    return (currentDate, formattedCurrentDate)
}

