//
//  IdleView.swift
//  WeatherJournal
//
//  Created by Ganesh Kumar Ananthi Dwarakan on 20/01/25.
//

import SwiftUI
import CoreLocation

struct IdleView: View {
    let locationManager: LocationManager
    
    init(locationManager: LocationManager = .shared) {
        self.locationManager = locationManager
    }
    
    var body: some View {
        if locationManager.location == nil {
            ProgressView("Getting location...")
        } else {
            ContentUnavailableView("Unable to fetch location", systemImage: "location.app", description: Text("please try again.."))
        }
    }
}

#Preview {
    IdleView()
}
