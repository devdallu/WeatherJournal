//
//  ConfigurationKeys.swift
//  WeatherJournal
//
//  Created by Ganesh Kumar Ananthi Dwarakan on 19/01/25.
//

import Foundation

protocol Environment {
    var baseURL: String { get }
    var defaultHeaders: [String: String] { get }
    var apiKey: String { get }
}

// MARK: - Environment Configuration
enum AppEnvironment: String, Environment {
    case development
    case staging
    case production
    
    var baseURL: String {
        switch self {
        case .development:
            return "https://api.openweathermap.org/data/2.5"
        case .staging:
            return "https://api.openweathermap.org/data/2.5"
        case .production:
            return "https://api.openweathermap.org/data/2.5"
        }
    }
    
    var defaultHeaders: [String: String] {
        [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
    }
    
    var apiKey: String {
        do {
            return try Self.getAPIKey(for: self)
        } catch {
            fatalError("Failed to retrieve API key for environment: \(self). Error: \(error)")
        }
    }
}

extension AppEnvironment {
    private static func getAPIKey(for environment: AppEnvironment) throws -> String {
           guard let plistPath = Bundle.main.path(forResource: "Config", ofType: "plist"),
                 let plistData = FileManager.default.contents(atPath: plistPath),
                 let plist = try PropertyListSerialization.propertyList(from: plistData, format: nil) as? [String: Any],
                 let apiKeys = plist["API_KEYS"] as? [String: String] else {
               throw ConfigurationError.missingPlistFile
           }
           
           let environmentKey = environment.rawValue.uppercased()
           guard let apiKey = apiKeys[environmentKey] else {
               throw ConfigurationError.invalidKey
           }
           
           return apiKey
       }
}

