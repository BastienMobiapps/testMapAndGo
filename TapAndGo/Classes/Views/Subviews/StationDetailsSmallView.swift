//
//  StationDetailsSmallView.swift
//  TapAndGo
//
//  Created by bastien lebrun on 12/04/2021.
//

import SwiftUI

struct StationDetailsSmallView: View {
    
    @Binding var station: Station
    
    var body: some View {
        VStack {
            HStack {
                Text("\(Translations.station.rawValue) \(Translations.stationInfoNumber.rawValue)\(String(station.number ?? 1))")
                    .font(.footnote)
                Spacer()
            }
            
            HStack {
                Text("\(station.address ?? "")")
                    .font(.footnote)
                Spacer()
            }
            
            HStack {
                Text("\(Translations.stationInfoBikes.rawValue): \(station.totalStands?.availabilities?.bikes ?? 0)")
                    .font(.footnote)
                Spacer()
            }
            
            HStack {
                Text("\(Translations.stationInfoBikeStands.rawValue): \(station.totalStands?.availabilities?.stands ?? 0)")
                    .font(.footnote)
                Spacer()
            }
            
            if let date = DateHelper.date(fromString: station.lastUpdate ?? "") {
                HStack {
                    Text("\(Translations.stationInfoLastUpdate.rawValue): \(DateHelper.dateString(date: date))")
                        .font(.footnote)
                    Spacer()
                }
            }
            
            Spacer()
        }
        .padding(.horizontal)
        .navigationBarTitle((station.name ?? ""), displayMode: .inline)
    }
}
