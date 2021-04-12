//
//  StationDetails.swift
//  TapAndGo
//
//  Created by bastien lebrun on 08/04/2021.
//

import SwiftUI

struct StationDetailsView: View {
    
    @Binding var station: Station
    
    var body: some View {
        VStack {
            HStack {
                Text("\(Translations.station.rawValue) \(Translations.stationInfoNumber.rawValue) \(String(station.number ?? 1))")
                Spacer()
            }.padding(.top)
            
            HStack {
                Text("\(Translations.stationInfoContract.rawValue): \(station.contractName?.capitalized ?? "")")
                Spacer()
            }
            
            HStack {
                Text("\(Translations.stationInfoAddress.rawValue): \(station.address ?? "")")
                Spacer()
            }.padding(.top)
            
            HStack {
                Text("\(Translations.stationInfoBikes.rawValue): \(station.totalStands?.availabilities?.bikes ?? 0)")
                Spacer()
            }.padding(.top)
            
            HStack {
                Text("\(Translations.stationInfoBikeStands.rawValue): \(station.totalStands?.availabilities?.stands ?? 0)")
                Spacer()
            }
            
            if let date = DateHelper.date(fromString: station.lastUpdate ?? "") {
                HStack {
                    Text("\(Translations.stationInfoLastUpdate.rawValue): ")
                    Text(DateHelper.dateString(date: date))
                    Spacer()
                }
            }
            
            Spacer()
        }
        .padding(.horizontal)
        .navigationBarTitle((station.name ?? ""), displayMode: .inline)
    }
}
