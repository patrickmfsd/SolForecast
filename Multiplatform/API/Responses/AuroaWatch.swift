//
//  AuroaWatch.swift
//  SolForecast
//
//  Created by Patrick Mifsud on 14/5/2024.
//

import Foundation

struct AuroraWatchResponse: Codable {
    let data: [AuroraWatchData]
//    let errors: [ResponseError]
}

struct AuroraWatchData: Codable {
    let issueTime: String
    let startDate: String
    let endDate: String
    let cause: String
    let kAus: Int
    let latBand: String
    let comments: String
    
    enum CodingKeys: String, CodingKey {
        case issueTime = "issue_time"
        case startDate = "start_date"
        case endDate = "end_date"
        case cause = "cause"
        case kAus = "k_aus"
        case latBand = "lat_band"
        case comments
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.issueTime = try container.decode(String.self, forKey: .issueTime)
        self.startDate = try container.decode(String.self, forKey: .startDate)
        self.endDate = try container.decode(String.self, forKey: .endDate)
        self.cause = try container.decode(String.self, forKey: .cause)
        self.kAus = try container.decode(Int.self, forKey: .kAus)
        self.latBand = try container.decode(String.self, forKey: .latBand)
        self.comments = try container.decode(String.self, forKey: .comments)
    }
}
