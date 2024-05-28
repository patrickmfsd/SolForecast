//
//  KIndex.swift
//  SolForecast
//
//  Created by Patrick Mifsud on 15/5/2024.
//

import Foundation

struct KIndexResponse: Codable {
    let data: [KIndexData]
//    let errors: [ResponseError]
}

struct KIndexData: Codable {
    let validTime: String
    let analysisTime: String
    let index: Int
    
    enum CodingKeys: String, CodingKey {
        case validTime = "valid_time"
        case analysisTime = "analysis_time"
        case index
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        validTime = try container.decode(String.self, forKey: .validTime)
        analysisTime = try container.decode(String.self, forKey: .analysisTime)
        index = try container.decode(Int.self, forKey: .index)
    }
}
