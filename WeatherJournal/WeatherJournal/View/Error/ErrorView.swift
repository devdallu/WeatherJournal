//
//  ErrorView.swift
//  WeatherJournal
//
//  Created by Ganesh Kumar Ananthi Dwarakan on 19/01/25.
//
import SwiftUI

struct ErrorView: View {
    let message: String
    let retryAction: () async -> Void
    
    var body: some View {
        ContentUnavailableView {
            Label(
                message,
                systemImage: "wifi.slash"
            )
        } description: {
            Text(
                "Check your internet connection"
            )
        } actions: {
            Button(
                "Refresh"
            ) {
                Task(priority: .high){
                    await retryAction()
                }
            }
        }
    }
}

#Preview {
    ErrorView(
        message: "No internet connection"
    ) {
        print(
            "Button Tapped"
        )
    }
}
