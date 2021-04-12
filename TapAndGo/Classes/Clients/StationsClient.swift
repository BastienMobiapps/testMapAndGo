//
//  StationsClient.swift
//  TapAndGo
//
//  Created by bastien lebrun on 08/04/2021.
//

import Foundation

class StationsClient {
    
    static func getStations(countryCode: String, completion: @escaping ([Station], String?) -> Void)  {
        var stationsGlobal: [Station] = []
        let group = DispatchGroup()
        ContractsClient.getContracts(countryCode: countryCode) { (contracts, error) in
            guard error == nil else {
                completion([], error?.description)
                return
            }
            
            for contract in contracts {
                group.enter()
                guard
                    let name = contract.name,
                    let url = URL(string: Routes.getStations(contractName: name).value())
                else { return }
                var request = URLRequest(url: url)
                request.httpMethod = "GET"
                URLSession.shared.dataTask(with: request) { (data, res, error) in
                    guard
                        let data = data,
                        let stations = try? JSONDecoder().decode([Station].self, from: data)
                    else {
                        group.leave()
                        return
                    }
                    stationsGlobal += stations
                    group.leave()
                }.resume()
            }
            
            group.notify(queue: DispatchQueue.main) {
                completion(stationsGlobal, nil)
            }
        }
    }
}
