//
//  DefaultWeatherFormatter.swift
//  WeatherJournal
//
//  Created by Ganesh Kumar Ananthi Dwarakan on 20/01/25.
//
import Foundation

protocol WeatherDataFormatter {
    func formatTemperature(_ kelvin: Double?) -> String
    func formatWindSpeed(_ speed: Double?) -> String
    func formatVisibility(_ meters: Int?) -> String
    func formatTimestamp(_ timestamp: Int?) -> String
}

// MARK: - Formatters
struct DefaultWeatherFormatter: WeatherDataFormatter {
    func formatTemperature(_ kelvin: Double?) -> String {
        guard let kelvin = kelvin else { return "N/A" }
        return "\(Int(kelvin - 273.15))°C"
    }
    
    func formatWindSpeed(_ speed: Double?) -> String {
        guard let speed = speed else { return "N/A" }
        return "\(speed) m/s"
    }
    
    func formatVisibility(_ meters: Int?) -> String {
        guard let meters = meters else { return "N/A" }
        return "\(meters / 1000) km"
    }
    
    func formatTimestamp(_ timestamp: Int?) -> String {
        guard let timestamp = timestamp else { return "N/A" }
        return DateUtils.formatUnixTimestamp(timestamp)
    }
}
