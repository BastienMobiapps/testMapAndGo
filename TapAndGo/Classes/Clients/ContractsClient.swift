//
//  ContractsClient.swift
//  TapAndGo
//
//  Created by bastien lebrun on 08/04/2021.
//

import Foundation

class ContractsClient {
    
    static func getContracts(countryCode: String, completion: @escaping ([Contracts], String?) -> Void) {
        guard let url = URL(string: Routes.getContracts.value()) else {
            completion([], Errors.urlParameters.rawValue)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { (data, res, error) in
            guard
                let data = data,
                let stations = try? JSONDecoder().decode([Contracts].self, from: data)
            else {
                completion([], Errors.decoding.rawValue)
                return
            }
            completion(stations.filter { $0.countryCode == countryCode }, nil)
        }.resume()
    }
    
}
