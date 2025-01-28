//
//  LoadingView.swift
//  WeatherJournal
//
//  Created by Ganesh Kumar Ananthi Dwarakan on 19/01/25.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                .scaleEffect(UIConstants.scale, anchor: .center)
        }
    }
}

// MARK: - Constants
private extension LoadingView {
    enum UIConstants {
        static let scale: CGFloat = 2.0
    }
}

#Preview {
    LoadingView()
}
