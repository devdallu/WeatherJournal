//
//  DateFormat.swift
//  WeatherJournal
//
//  Created by Ganesh Kumar Ananthi Dwarakan on 20/01/25.
//
import Foundation

struct DateUtils {
    
    /// Converts a Unix timestamp to a formatted time string.
    /// - Parameter timestamp: The Unix timestamp to be formatted.
    /// - Returns: A formatted string representing the time (e.g., "12:34 PM").
    static func formatUnixTimestamp(_ timestamp: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
