//
//  ContentView.swift
//  TapAndGo
//
//  Created by bastien lebrun on 08/04/2021.
//

import SwiftUI

struct ContentView: View {
    
    var stationManager = StationManager()
    @State private var showingSearchView = false
    
    var body: some View {
        TabView {
            NavigationView {
                MapOverview(stationManager: stationManager)
                    .navigationBarTitle(Translations.mapTitle.rawValue, displayMode: .inline)
                    .navigationBarItems(
                        trailing:
                            HStack {
                                Button(
                                    action: { showingSearchView = true },
                                    label: { Image(systemName: "magnifyingglass") })
                            })
            }
            .tabItem { Label("Map", systemImage: "map") }
            
            NavigationView {
                StationsView(stationManager: stationManager)
                    .navigationBarTitle(Translations.stations.rawValue, displayMode: .inline)
                    .navigationBarItems(
                        trailing:
                            HStack {
                                Button(
                                    action: { showingSearchView = true },
                                    label: { Image(systemName: "magnifyingglass") })
                            })
            }
            .tabItem { Label(Translations.stations.rawValue, systemImage: "bicycle") }
            
            NavigationView {
                TravelView(stationManager: stationManager)
                    .navigationBarTitle(Translations.findStationTitle.rawValue, displayMode: .inline)
            }
            .tabItem { Label("Itinéraire", systemImage: "list.bullet") }
            
        }
        .sheet(isPresented: $showingSearchView, content: {
            SearchView(stationManager: stationManager)
        })
        .onAppear() {
            stationManager.setupStations(countryCode: "FR")
        }
    }
}
