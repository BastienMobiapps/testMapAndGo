//
//  AddressView.swift
//  TapAndGo
//
//  Created by bastien lebrun on 12/04/2021.
//

import SwiftUI
import MapKit

struct AddressView: View {
    
    private let locationService = LocationService()
    @ObservedObject var stationManager: StationManager
    @State var headerTitle: String = Translations.start.rawValue
    // Stored
    @State var address: String
    @State var location: MKMapItem?
    @State var closestStation: Station?
    @State var bikesNeeded: Int = 0
    @State var placesNeeded: Int = 0
    
    var body: some View {
        Section(header: Text(headerTitle), content: {
            TextField(Translations.addressPlaceholder.rawValue, text: Binding<String> (
                get: { address },
                set: { setAddress($0) }
            ))
            if closestStation == nil {
                ForEach(locationService.searchResult.results, id: \.self) { result in
                    Button(getName(item: result)) {
                        selectAddress(result)
                    }
                }
            }
        })
        
        if let station = closestStation {
            Section {
                Text(Translations.closestStation.rawValue)
                let binding = Binding(
                    get: { station },
                    set: { (_) in }
                )
                StationDetailsSmallView(station: binding)
            }
        }
    }
    
    private func setAddress(_ _address: String) {
        closestStation = nil
        address = _address
        locationService.search(query: _address)
    }
    
    private func selectAddress(_ _result: MKMapItem) {
        let _name = getName(item: _result)
        let _position = (_result.placemark.coordinate.latitude, _result.placemark.coordinate.longitude)
        address = _name
        location = _result
        closestStation = stationManager.getClosestsStation(fromPoint: _position, bikesNeeded: bikesNeeded, placesNeeded: placesNeeded).first
    }
    
    private func getName(item: MKMapItem) -> String {
        guard item.name != item.placemark.locality else {
            return item.name ?? ""
        }
        return "\(item.name ?? "") \(item.placemark.postalCode ?? "") \(item.placemark.locality ?? "")"
    }
}

