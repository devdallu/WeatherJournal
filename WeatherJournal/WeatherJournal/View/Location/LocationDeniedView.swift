//
//  LocationDeniedView.swift
//  WeatherJournal
//
//  Created by Ganesh Kumar Ananthi Dwarakan on 20/01/25.
//


import SwiftUI

struct LocationDeniedView: View {
    let locationManager: LocationManager
    @SwiftUI.Environment(\.colorScheme) var colorScheme

    init(locationManager: LocationManager = .shared) {
        self.locationManager = locationManager
    }
    
    var body: some View {
        VStack(spacing: UIConstants.Vspacing) {
            Text("Location Access Required")
                .font(.skyHeadline)
                .foregroundStyle(NewsColors.commonText(colorScheme == .dark))
            
            Text("Please enable location access in Settings to get weather for your current location.")
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .foregroundStyle(NewsColors.commonText(colorScheme == .dark))
            
            Button("Open Settings") {
                locationManager.openSettings()
            }
            .buttonStyle(.bordered)
        }
        .padding()
    }
}

// MARK: - Constants
private extension LocationDeniedView {
    enum UIConstants {
        static let Vspacing: CGFloat = 20
    }
}

#Preview {
    LocationDeniedView()
}
