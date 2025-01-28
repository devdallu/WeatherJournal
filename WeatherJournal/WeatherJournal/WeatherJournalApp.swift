//
//  WeatherJournalApp.swift
//  WeatherJournal
//
//  Created by Ganesh Kumar Ananthi Dwarakan on 18/01/25.
//

import SwiftUI
import SwiftfulRouting

@main
struct WeatherJournalApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    private let container = DependencyContainer.shared

    var body: some Scene {
        WindowGroup {
            RouterView { _ in
                WeatherView(viewModel: container.createWeatherViewModel())
            }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    private let container = DependencyContainer.shared
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        Task {  @MainActor in
            container.locationManager.requestLocationPermission()
        }
        return true
    }
}

