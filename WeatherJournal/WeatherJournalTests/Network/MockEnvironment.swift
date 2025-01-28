//
//  MockEnvironment.swift
//  WeatherJournalTests
//
//  Created by Ganesh Kumar Ananthi Dwarakan on 19/01/25.
//

import Foundation
@testable import WeatherJournal

struct MockEnvironment: Environment {
    let baseURL: String = "https://api.openweathermap.org/data/2.5"
    let apiKey: String = "0da38a9af82b02f1c6a870dfd76f2b4e"
    let defaultHeaders: [String: String] = ["Content-Type": "application/json"]
}
