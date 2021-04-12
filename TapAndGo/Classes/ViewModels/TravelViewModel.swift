//
//  TravelViewModel.swift
//  TapAndGo
//
//  Created by bastien lebrun on 12/04/2021.
//

import Foundation
import MapKit

class TravelViewModel: ObservableObject {
    
    @Published var startText: String = ""
    @Published var startItem: MKMapItem? = nil
    @Published var startingStation: Station? = nil
    
    @Published var destinationText: String = ""
    @Published var destinationItem: MKMapItem? = nil
    @Published var destinationStation: Station? = nil
    
}
