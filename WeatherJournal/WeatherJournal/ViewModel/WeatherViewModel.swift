//
//  WeatherViewModel.swift
//  WeatherJournal
//
//  Created by Ganesh Kumar Ananthi Dwarakan on 18/01/25.
//

import Foundation
import SwiftUI
import Connectivity

@MainActor
final class WeatherViewModel: ObservableObject {
    @Published private(set) var state: WeatherViewState = .idle
    
    private let weatherService: WeatherServiceProtocol
    private let connectivityService: ConnectivityServiceProtocol
    private var cancellable: Task<Void, Never>?
    
    init(weatherService: WeatherServiceProtocol, connectivityService: ConnectivityServiceProtocol) {
        self.weatherService = weatherService
        self.connectivityService = connectivityService
    }
    
    func fetchWeatherStatus(latitude: Double, longitude: Double) async {
        cancellable?.cancel()
        
        setState(.loading)
        
        let connectivityStatus = await connectivityService.checkConnectionStatus()
        
        switch connectivityStatus {
        case .connected, .connectedViaCellular, .connectedViaWiFi, .connectedViaEthernet:
            do {
                let weather = try await weatherService.fetchWeather(
                    latitude: latitude,
                    longitude: longitude
                )
                setState(.loaded(weather))
            } catch {
                setState(.error(error.localizedDescription))
            }
            
        case .notConnected, .connectedViaCellularWithoutInternet,
                .connectedViaWiFiWithoutInternet, .connectedViaEthernetWithoutInternet:
            setState(.error("No internet connection"))
            
        case .determining:
            print("Determining connectivity status")
        }
    }
    
    private func setState(_ newState: WeatherViewState) {
        state = newState
    }
    
    deinit {
        cancellable?.cancel()
    }
}
