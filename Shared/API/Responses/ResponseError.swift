//
//  ResponseError.swift
//  SolForecast
//
//  Created by Patrick Mifsud on 15/5/2024.
//

import Foundation

struct ResponseError: Codable {
    let code: Int
    let message: String
}
