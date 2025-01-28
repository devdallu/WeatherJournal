//
//  DependencyContainer.swift
//  WeatherJournal
//
//  Created by Ganesh Kumar Ananthi Dwarakan on 19/01/25.
//

import Foundation

final class DependencyContainer {
    static let shared = DependencyContainer()
    
    private init() {}
    
    lazy var locationManager: LocationManager = {
        LocationManager.shared
    }()
    
    private lazy var weatherService: WeatherServiceProtocol = {
        WeatherService()
    }()
    
    private lazy var connectivityService: ConnectivityServiceProtocol = {
        ConnectivityService()
    }()
    
    @MainActor
    func createWeatherViewModel() -> WeatherViewModel {
        WeatherViewModel(
            weatherService: weatherService,
            connectivityService: connectivityService
        )
    }
}
