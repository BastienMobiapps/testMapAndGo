//
//  Contracts.swift
//  TapAndGo
//
//  Created by bastien lebrun on 08/04/2021.
//

import Foundation

// MARK: - Contracts
struct Contracts: Codable {
    let name, commercialName, countryCode: String?
    let cities: [String]?

    enum CodingKeys: String, CodingKey {
        case name
        case commercialName = "commercial_name"
        case countryCode = "country_code"
        case cities
    }
}
