//
//  AIndex.swift
//  SolForecast
//
//  Created by Patrick Mifsud on 13/5/2024.
//

import Foundation

struct AIndexResponse: Codable {
    let data: [[AIndexData]]
}

struct AIndexData: Codable, Identifiable {
    let validTime: String
    let index: String
    
    var id: String { validTime } // Assuming validTime is unique for each AIndexData
    
    enum CodingKeys: String, CodingKey {
        case validTime = "valid_time"
        case index
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        validTime = try container.decode(String.self, forKey: .validTime)
        index = try container.decode(String.self, forKey: .index)
    }
}
