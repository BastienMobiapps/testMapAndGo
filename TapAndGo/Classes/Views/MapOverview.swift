//
//  MapOverview.swift
//  TapAndGo
//
//  Created by bastien lebrun on 08/04/2021.
//

import SwiftUI
import MapKit
import CoreLocation

struct MapOverview: View {
    
    @ObservedObject var stationManager: StationManager
    
    private let locationManager = LocationManager()
    private let locationService = LocationService()
    
    @State private var showingStationDetails = false
    @State private var trackingMode = MapUserTrackingMode.follow
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 47, longitude: -1),
        span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
    )
    @State private var stations: [Station] = []
    
    var body: some View {
        VStack {
            Map(
                coordinateRegion: $region,
                interactionModes: .all,
                showsUserLocation: true,
                userTrackingMode: $trackingMode,
                annotationItems: stations,
                annotationContent:
                    { station -> MapAnnotation<StationButtonView> in
                        let coordinate = CLLocationCoordinate2D(
                            latitude: station.position?.latitude ?? 0,
                            longitude: station.position?.longitude ?? 0
                        )
                        return MapAnnotation(
                            coordinate: coordinate,
                            anchorPoint: CGPoint(x: 0.05, y: 0.05),
                            content: {
                                StationButtonView(station: station)
                            }
                        )
                    }
            )
        }
        .onAppear() {
            let userLocation = getUserLocation()
            region.center.latitude = userLocation.latitude
            region.center.longitude = userLocation.longitude
            stations = stationManager.stations
        }
        .onReceive(stationManager.stationsUpdated) {
            stations = stationManager.stations
        }
        
    }
    
    private func getUserLocation() -> (latitude: Double, longitude: Double) {
        return (
            locationManager.location?.coordinate.latitude ?? 0,
            locationManager.location?.coordinate.longitude ?? 0
        )
    }
}
