//
//  LocationService.swift
//  TapAndGo
//
//  Created by bastien lebrun on 12/04/2021.
//

import Foundation
import Combine
import CoreLocation
import MapKit

enum RequestState {
    case loading, error, success, empty
}

struct LocationSearchResult {
    var results: [MKMapItem] = []
    var state: RequestState = .success
}

class LocationService: NSObject, ObservableObject {
    
    @Published var searchResult: LocationSearchResult = LocationSearchResult()
    
    func search(query: String) {
        
        guard !query.isEmpty else {
            searchResult.results = []
            searchResult.state = .success
            return
        }
        
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = query
        
        let search = MKLocalSearch(request: searchRequest)
        searchResult.state = .loading
        
        search.start { (response, error) in
            guard let response = response else {
                self.searchResult.results = []
                self.searchResult.state = .error
                return
            }
            self.searchResult.results = response.mapItems
            self.searchResult.state = response.mapItems.count > 0 ? .success : .empty
        }
    }
}
