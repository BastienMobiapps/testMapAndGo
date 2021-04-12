//
//  SearchViewModel.swift
//  TapAndGo
//
//  Created by bastien lebrun on 12/04/2021.
//

import Foundation

class SearchViewModel: ObservableObject {
    
    @Published var contractName: String = ""
    @Published var stationName: String = ""
    @Published var status: StationsStatus?
    @Published var bikesNeeded: Int = 0
    @Published var placesNeeded: Int = 0
    
    func applyFilters(allStations: [Station]) -> [Station] {
        return allStations
            .filter(filterByContract(station:))
            .filter(filterByName(station:))
            .filter(filterByStatus(station:))
            .filter(filterByBikesNeeded(station:))
            .filter(filterByPlacesNeeded(station:))
    }
    
    private func filterByContract(station: Station) -> Bool {
        guard !contractName.isEmpty else { return true }
        return station.contractName?.lowercased()
            .contains(contractName.lowercased()) ?? false
    }
    
    private func filterByStatus(station: Station) -> Bool {
        guard let status = status else { return true }
        return station.status == status.rawValue
    }
    
    private func filterByName(station: Station) -> Bool {
        guard !stationName.isEmpty else { return true }
        return station.name?.lowercased()
            .contains(stationName.lowercased()) ?? false
    }
    
    private func filterByBikesNeeded(station: Station) -> Bool {
        guard bikesNeeded > 0 else { return true }
        return station.totalStands?.availabilities?.bikes ?? 0 >= bikesNeeded
    }
    
    private func filterByPlacesNeeded(station: Station) -> Bool {
        guard placesNeeded > 0 else { return true }
        return station.totalStands?.availabilities?.stands ?? 0 >= placesNeeded
    }
    
}
