//
//  Routes.swift
//  TapAndGo
//
//  Created by bastien lebrun on 08/04/2021.
//

import Foundation

private let rootApi = "https://api.jcdecaux.com"
private let apiKey = "5f5489984416eac27a7d54151defff2428738147"

enum Routes {
    case getContracts
    case getStation(stationNumber: Int, contractName: String)
    case getAllStations
    case getStations(contractName: String)
    case getParkings(contractName: String)
    case getParking(contractName: String, parkNumber: Int)
    
    func value() -> String {
        switch self {
        case .getContracts:
            return "\(rootApi)/vls/v3/contracts?apiKey=\(apiKey)"
        case .getStation(let stationNumber, let contractName):
            return  "\(rootApi)/vls/v3/stations/\(stationNumber)?contract=\(contractName)&apiKey=\(apiKey)"
        case .getAllStations:
            return "\(rootApi)/vls/v3/stations?apiKey=\(apiKey)"
        case .getStations(let contractName):
            return "\(rootApi)/vls/v3/stations?contract=\(contractName)&apiKey=\(apiKey)"
        case .getParkings(let contractName):
            return "\(rootApi)/parking/v1/contracts/\(contractName)/parks?apiKey=\(apiKey)"
        case .getParking(let contractName, let parkNumber):
            return "\(rootApi)/parking/v1/contracts/\(contractName)/parks/\(parkNumber)?apiKey=\(apiKey)"
        }
    }
    
}
