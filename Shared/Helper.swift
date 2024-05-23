//
//  Helper.swift
//  SolForecast
//
//  Created by Patrick Mifsud on 13/5/2024.
//

import Foundation
import SwiftUI

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

