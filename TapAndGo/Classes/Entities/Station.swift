//
//  Station.swift
//  TapAndGo
//
//  Created by bastien lebrun on 08/04/2021.
//

import Foundation

// MARK: - Station
struct Station: Codable, Hashable, Identifiable {
    static func == (lhs: Station, rhs: Station) -> Bool {
        return lhs.number == rhs.number
            && lhs.name == rhs.name
            && lhs.address == rhs.address
            && lhs.contractName == rhs.contractName
    }
    let id = UUID()
    var number: Int?
    var contractName, name, address: String?
    var position: Position?
    var banking, bonus: Bool?
    var status: String?
    var lastUpdate: String?
    var connected, overflow: Bool?
    var totalStands, mainStands: Stands?
    
    enum CodingKeys: String, CodingKey {
        case number, contractName, name, address, position, banking, bonus
        case status, lastUpdate, connected, overflow, totalStands, mainStands
    }
}

// MARK: - Stands
struct Stands: Codable, Hashable {
    var availabilities: Availabilities?
    var capacity: Int?
}

// MARK: - Availabilities
struct Availabilities: Codable, Hashable {
    var bikes, stands, mechanicalBikes, electricalBikes: Int?
    var electricalInternalBatteryBikes, electricalRemovableBatteryBikes: Int?
}

// MARK: - Position
struct Position: Codable, Hashable {
    var latitude, longitude: Double?
}
