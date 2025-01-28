//
//  MockResponseType.swift
//  WeatherJournalTests
//
//  Created by Ganesh Kumar Ananthi Dwarakan on 19/01/25.
//

import Foundation
@testable import WeatherJournal

struct MockWeatherResponse {
    static func create() -> WeatherResponse {
        return WeatherResponse(
            coord: Coord(lon: -122.4194, lat: 37.7749),
            weather: [
                Weather(
                    id: 800,
                    main: "Clear",
                    description: "clear sky",
                    icon: "01d"
                )
            ],
            base: "stations",
            main: Main(
                temp: 25.0,
                feelsLike: 24.5,
                tempMin: 23.0,
                tempMax: 26.0,
                pressure: 1013,
                humidity: 60,
                seaLevel: 1013,
                grndLevel: 1010
            ),
            visibility: 10000,
            wind: Wind(
                speed: 3.6,
                deg: 160,
                gust: 7.2
            ),
            clouds: Clouds(all: 0),
            dt: 1643356800,
            sys: Sys(
                country: "US",
                sunrise: 1643342400,
                sunset: 1643381200
            ),
            timezone: -28800,
            id: 5391959,
            name: "San Francisco",
            cod: 200
        )
    }
}
