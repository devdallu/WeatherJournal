//
//  LocationPermissionView.swift
//  WeatherJournal
//
//  Created by Ganesh Kumar Ananthi Dwarakan on 20/01/25.
//
import SwiftUI

struct LocationPermissionView: View {
    let requestPermission: () -> Void
    @SwiftUI.Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(spacing: UIConstants.Vspacing) {
            circleLocation()
            Text("Enable Location Services")
                .font(.skyHeadline)
                .fontWeight(.bold)
            
            Text("To provide you with accurate weather information, we need access to your location. This helps us show you real-time weather updates for your area.")
                .font(.body)
                .foregroundColor(NewsColors.tertiaryText(colorScheme == .dark))
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Button(action: requestPermission) {
                Text("Allow Location Access")
                    .font(.skyBodyMedium1)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(NewsColors.brandBlueGradient2)
                    .clipShape(RoundedRectangle(cornerRadius: UIConstants.cornerRadius))
            }
            
            Text("You can change this setting at any time in your device's settings")
                .font(.caption)
                .foregroundColor(NewsColors.tertiaryText(colorScheme == .dark))
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
        .padding()
    }
    
    private func circleLocation() -> some View {
        Circle()
            .fill(NewsColors.brandBlueGradient1.opacity(UIConstants.colorOpacity))
            .frame(width: UIConstants.width, height: UIConstants.height)
            .overlay {
                Image(systemName: "location.fill")
                    .font(.system(size: UIConstants.imageScale))
                    .foregroundColor(.blue)
            }
            .padding(.top)
    }
}

// MARK: - Constants
private extension LocationPermissionView {
    enum UIConstants {
        static let Vspacing: CGFloat = 16
        static let EnableVspacing: CGFloat = 12
        static let AllowVspacing: CGFloat = 16
        static let imageScale: CGFloat = 36
        static let width: CGFloat = 80
        static let height: CGFloat = 80
        static let cornerRadius: CGFloat = 12
        static let colorOpacity: CGFloat = 0.2
    }
}


#Preview {
    LocationPermissionView(requestPermission: {})
        .padding()
}
