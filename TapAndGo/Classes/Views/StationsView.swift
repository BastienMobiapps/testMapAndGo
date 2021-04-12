//
//  Stations.swift
//  TapAndGo
//
//  Created by bastien lebrun on 08/04/2021.
//

import SwiftUI

struct StationsSection {
    var contractName: String
    var stations: [Station] = []
}

struct StationsView: View {
    
    @ObservedObject var stationManager: StationManager
    @State var sections: [StationsSection] = []
    
    var body: some View {
        List {
            ForEach(0..<sections.count, id: \.self) { iSection in
                Section(
                    header: Text(sections[iSection].contractName),
                    content: {
                        ForEach(0..<sections[iSection].stations.count, id: \.self) { iStation in
                            let binding = Binding(
                                get: { sections[iSection].stations[iStation] },
                                set: { _,_ in  }
                            )
                            NavigationLink(destination: StationDetailsView(station: binding)) {
                                let station = sections[iSection].stations[iStation]
                                Text("\(Translations.station.rawValue): \(station.name ?? "")")
                            }
                        }
                    }
                )
            }
        }
        .onAppear() { setupSections() }
        .onReceive(stationManager.stationsUpdated) { setupSections() }
    }
    
    private func setupSections() {
        sections = []
        stationManager.stations.forEach { (station) in
            let contractName = station.contractName ?? ""
            if let _index = sections
                .firstIndex(where: { $0.contractName == contractName }) {
                sections[_index].stations.append(station)
            }
            else {
                var section = StationsSection(contractName: contractName)
                section.stations.append(station)
                sections.append(section)
            }
        }
    }
}
