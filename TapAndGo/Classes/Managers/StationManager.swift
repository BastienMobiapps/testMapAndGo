//
//  StationManager.swift
//  TapAndGo
//
//  Created by bastien lebrun on 09/04/2021.
//

import Foundation
import CoreLocation
import Combine

class StationManager: ObservableObject {
    
    let stationsUpdated = PassthroughSubject<(), Never>()
    
    @Published private(set) var stations: [Station] = []
    
    var resetList: [Station] = []
    
    func setupStations(countryCode: String) {
        StationsClient.getStations(countryCode: countryCode) { (stations, error) in
            self.stations = stations
            self.resetList = stations
            self.stationsUpdated.send(())
        }
    }
    
    func updateSections(_stations: [Station]) {
        stations = _stations
        stationsUpdated.send(())
    }
    
    func getClosestsStation(fromPoint: (latitude: Double, longitude: Double), top: Int = 1, bikesNeeded: Int = 0, placesNeeded: Int = 0) -> [Station] {
        let fromPos = CLLocation(latitude: fromPoint.latitude, longitude: fromPoint.longitude)
        let closeStations = stations.sorted { (station1, station2) -> Bool in
            guard
                let lat1 = station1.position?.latitude,
                let lon1 = station1.position?.longitude,
                let lat2 = station2.position?.latitude,
                let lon2 = station2.position?.longitude
            else { return false }
            
            let pos1 = CLLocation(latitude: lat1, longitude: lon1)
            let pos2 = CLLocation(latitude: lat2, longitude: lon2)
            return pos1.distance(from: fromPos) < pos2.distance(from: fromPos)
        }
        return Array(closeStations.prefix(top))
            .filter { (station) -> Bool in stationFilter(station, bikesNeeded, placesNeeded) }
    }
    
    private func stationFilter(_ station: Station, _ bikesNeeded: Int, _ placesNeeded: Int) -> Bool {
        return
            station.totalStands?.availabilities?.bikes ?? 0 >= bikesNeeded &&
            station.totalStands?.availabilities?.stands ?? 0 >= placesNeeded
    }
    
}
