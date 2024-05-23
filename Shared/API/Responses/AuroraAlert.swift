//
//  AuroraAlert.swift
//  SolForecast
//
//  Created by Patrick Mifsud on 13/5/2024.
//

import Foundation

struct AuroraAlertResponse: Codable {
    let data: [AuroraAlertData]
//    let errors: [ResponseError]
}

struct AuroraAlertData: Codable {
    let startTime: String
    let validUntil: String
    let kAus: Int = 0
    let latBand: String
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case startTime = "start_time"
        case validUntil = "valid_until"
        case kAus = "kaus"
        case latBand = "lat_band"
        case description
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.startTime = try container.decode(String.self, forKey: .startTime)
        self.validUntil = try container.decode(String.self, forKey: .validUntil)
        self.latBand = try container.decode(String.self, forKey: .latBand)
        self.description = try container.decode(String.self, forKey: .description)
    }
}
