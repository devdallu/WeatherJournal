//
//  WeatherDataProvider.swift
//  WeatherJournal
//
//  Created by Ganesh Kumar Ananthi Dwarakan on 20/01/25.
//

import SwiftUI

struct WeatherDataProvider {
    private let formatter: WeatherDataFormatter
    
    init(formatter: WeatherDataFormatter = DefaultWeatherFormatter()) {
        self.formatter = formatter
    }
    
    func getWeatherInfo(from weather: WeatherResponse) -> [WeatherInfo] {
        var infoItems: [WeatherInfo] = []
        
        // Location
        infoItems.append(WeatherInfo(
            icon: "mappin.circle.fill",
            title: "Location",
            value: weather.name ?? "Unknown Location"
        ))
        
        // Weather condition
        if let mainWeather = weather.weather?.first {
            infoItems.append(WeatherInfo(
                icon: "cloud.fill",
                title: "Condition",
                value: mainWeather.main ?? "Unknown"
            ))
            
            infoItems.append(WeatherInfo(
                icon: "text.bubble.fill",
                title: "Description",
                value: mainWeather.description?.capitalized ?? "Unknown"
            ))
        }
        
        // Temperature related
        if let main = weather.main {
            infoItems.append(WeatherInfo(
                icon: "thermometer",
                title: "Temperature",
                value: formatter.formatTemperature(main.temp)
            ))
            
            infoItems.append(WeatherInfo(
                icon: "thermometer.sun.fill",
                title: "Feels Like",
                value: formatter.formatTemperature(main.feelsLike)
            ))
            
            infoItems.append(WeatherInfo(
                icon: "humidity.fill",
                title: "Humidity",
                value: main.humidity.map { "\($0)%" } ?? "N/A"
            ))
        }
        
        // Wind
        if let wind = weather.wind {
            infoItems.append(WeatherInfo(
                icon: "wind",
                title: "Wind Speed",
                value: formatter.formatWindSpeed(wind.speed)
            ))
        }
        
        // Visibility
        infoItems.append(WeatherInfo(
            icon: "eye.fill",
            title: "Visibility",
            value: formatter.formatVisibility(weather.visibility)
        ))
        
        // Sun timings
        if let sys = weather.sys {
            infoItems.append(WeatherInfo(
                icon: "sunrise.fill",
                title: "Sunrise",
                value: formatter.formatTimestamp(sys.sunrise)
            ))
            
            infoItems.append(WeatherInfo(
                icon: "sunset.fill",
                title: "Sunset",
                value: formatter.formatTimestamp(sys.sunset)
            ))
        }
        
        return infoItems
    }
}
