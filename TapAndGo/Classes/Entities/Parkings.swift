//
//  Parkings.swift
//  TapAndGo
//
//  Created by bastien lebrun on 08/04/2021.
//

import Foundation

// MARK: - Parkings
struct Parkings: Codable {
    let contractName, name: String?
    let number: Int?
    let status: String?
    let position: Position?
    let accessType, lockerType: String?
    let hasSurveillance, isFree: Bool?
    let address, zipCode, city: String?
    let isOffStreet, hasElectricSupport, hasPhysicalReception: Bool?
}
