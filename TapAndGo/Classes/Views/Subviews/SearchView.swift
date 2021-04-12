//
//  SearchView.swift
//  TapAndGo
//
//  Created by bastien lebrun on 08/04/2021.
//

import SwiftUI

struct SearchView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var stationManager: StationManager
    @ObservedObject var viewModel: SearchViewModel = SearchViewModel()
    
    var body: some View {
        Text(Translations.stationFilter.rawValue)
            .font(.title)
        Form {
            Section {
                TextField(Translations.city.rawValue, text: Binding<String> (
                    get: { viewModel.contractName },
                    set: { viewModel.contractName = $0 }
                ))
                TextField(Translations.stationName.rawValue, text: Binding<String> (
                    get: { viewModel.stationName },
                    set: { viewModel.stationName = $0 }
                ))
                HStack {
                    Stepper(Translations.bikesNeeded.rawValue, value: Binding<Int> (
                        get: { viewModel.bikesNeeded },
                        set: { viewModel.bikesNeeded = $0 }
                    ),
                    in: 0...20)
                    Text(viewModel.bikesNeeded.description)
                }
                HStack {
                    Stepper(Translations.placesNeeded.rawValue, value: Binding<Int> (
                        get: { viewModel.placesNeeded },
                        set: { viewModel.placesNeeded = $0 }
                    ),
                    in: 0...20)
                    Text(viewModel.placesNeeded.description)
                }
                Toggle(Translations.stationOnlyOpen.rawValue, isOn: Binding<Bool> (
                    get: { viewModel.status == .open },
                    set: { viewModel.status = $0 ? .open : nil }
                ))
            }
            Section {
                Button(Translations.search.rawValue) {
                    stationManager.updateSections(_stations: viewModel.applyFilters(allStations: stationManager.resetList))
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
}
