//
//  WeatherInfoConvertible.swift
//  WeatherJournal
//
//  Created by Ganesh Kumar Ananthi Dwarakan on 20/01/25.
//
import Foundation

protocol WeatherInfoConvertible {
    var icon: String { get }
    var title: String { get }
    var value: String { get }
}

// MARK: - Models
struct WeatherInfo: WeatherInfoConvertible {
    let icon: String
    let title: String
    let value: String
}
