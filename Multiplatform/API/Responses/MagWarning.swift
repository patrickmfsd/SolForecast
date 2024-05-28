//
//  MagWarning.swift
//  SolForecast
//
//  Created by Patrick Mifsud on 15/5/2024.
//

import Foundation

struct MagWarningResponse: Codable {
    let data: [MagWarningData]
//    let errors: [ResponseError]
}

struct MagWarningData: Codable {
    let issueTime: String
    let startDate: String
    let endDate: String
    let cause: String
    let magWarningActivity: [MagWarningActivity]
    let comments: String? = "No Comments"
    
    enum CodingKeys: String, CodingKey {
        case issueTime = "issue_time"
        case startDate = "start_date"
        case endDate = "end_date"
        case cause
        case magWarningActivity = "activity"
        case comments = "comments"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.issueTime = try container.decode(String.self, forKey: .issueTime)
        self.startDate = try container.decode(String.self, forKey: .startDate)
        self.endDate = try container.decode(String.self, forKey: .endDate)
        self.cause = try container.decode(String.self, forKey: .cause)
        self.magWarningActivity = try container.decode([MagWarningActivity].self, forKey: .magWarningActivity)
    }
}

struct MagWarningActivity: Codable {
    let date: String
    let forecast: String
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.date = try container.decode(String.self, forKey: .date)
        self.forecast = try container.decode(String.self, forKey: .forecast)
    }
}
