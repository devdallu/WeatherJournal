//
//  ConfigurationError.swift
//  WeatherJournal
//
//  Created by Ganesh Kumar Ananthi Dwarakan on 19/01/25.
//

import Foundation

enum ConfigurationError: Error {
    case missingPlistFile
    case invalidKey
}
