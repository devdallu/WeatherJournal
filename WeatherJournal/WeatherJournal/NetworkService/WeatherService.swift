//
//  WeatherService.swift
//  WeatherJournal
//
//  Created by Ganesh Kumar Ananthi Dwarakan on 18/01/25.
//

import Foundation

protocol WeatherServiceProtocol {
    func fetchWeather(
        latitude: Double,
        longitude: Double
    ) async throws -> WeatherResponse
}

struct WeatherService: WeatherServiceProtocol {
    private let network: NetworkRequestable
    private let environment: Environment
    
    init(
        network: NetworkRequestable = NetworkService(),
        environment: Environment = AppEnvironment.development

    ) {
        self.network = network
        self.environment = environment
    }
    
    func fetchWeather(
        latitude: Double,
        longitude: Double
    ) async throws -> WeatherResponse {
     
        let request = APIBuilder(
            environment: environment,
            path: "/weather"
        )
            .addQueryParameters(
                [
                    "lat": String(
                        latitude
                    ),
                    "lon": String(
                        longitude
                    ),
                    "exclude": "current",
                    "appid": environment.apiKey
                ]
            )
            .build()
        
        return try await network
            .execute(
                request
            )
    }
}


