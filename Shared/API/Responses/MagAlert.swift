//
//  MagAlert.swift
//  SolForecast
//
//  Created by Patrick Mifsud on 13/5/2024.
//

import Foundation

struct MagAlertResponse: Codable {
    let data: [MagAlertData]
//    let errors: [ResponseError]
}

struct MagAlertData: Codable {
    let startTime: String
    let validUntil: String
    let gScale: Int
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case startTime = "start_time"
        case validUntil = "valid_until"
        case gScale
        case description
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.startTime = try container.decode(String.self, forKey: .startTime)
        self.validUntil = try container.decode(String.self, forKey: .validUntil)
        self.gScale = try container.decode(Int.self, forKey: .gScale)
        self.description = try container.decode(String.self, forKey: .description)
    }
}
