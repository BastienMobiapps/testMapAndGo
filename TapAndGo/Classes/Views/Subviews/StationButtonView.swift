//
//  StationButtonView.swift
//  TapAndGo
//
//  Created by bastien lebrun on 12/04/2021.
//

import SwiftUI

struct StationButtonView: View {
    @State private var showingStationDetails = false
    @State var station: Station

    var body: some View {
        Button(action: {
            showingStationDetails.toggle()
        }) {
            Image(systemName: "bicycle.circle")
                .padding()
                .foregroundColor(.blue)
                .font(.title)
        }
        .sheet(
            isPresented: $showingStationDetails,
            content: {
                StationDetailsView(station: self.$station)
            })
    }
}
