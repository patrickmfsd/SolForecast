//
//  DSTIndex.swift
//  SolForecast
//
//  Created by Patrick Mifsud on 15/5/2024.
//

import Foundation

struct DSTIndexResponse: Codable {
    let data: [[DSTIndexData]]
//    let errors: [ResponseError]
}

struct DSTIndexData: Codable {
    let validTime: String
    let index: String
    
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
