//
//  TravelView.swift
//  TapAndGo
//
//  Created by bastien lebrun on 09/04/2021.
//

import SwiftUI
import CoreLocation
import MapKit

struct TravelView: View {
    
    @ObservedObject var stationManager: StationManager
    @ObservedObject var viewModel: TravelViewModel = TravelViewModel()
    
    private let locationManager = LocationManager()
    
    var body: some View {
        Form {
            AddressView(
                stationManager: stationManager,
                address: viewModel.startText,
                location: viewModel.startItem,
                closestStation: viewModel.startingStation,
                bikesNeeded: 1)
            AddressView(
                stationManager: stationManager,
                headerTitle: Translations.arrival.rawValue,
                address: viewModel.destinationText,
                location: viewModel.destinationItem,
                closestStation: viewModel.destinationStation,
                placesNeeded: 1)
        }
    }
}

