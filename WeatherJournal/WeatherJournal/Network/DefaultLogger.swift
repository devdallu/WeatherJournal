//
//  DefaultLogger.swift
//  WeatherJournal
//
//  Created by Ganesh Kumar Ananthi Dwarakan on 18/01/25.
//

import Foundation

struct DefaultLogger: NetworkLoggable {
    func logRequest(_ request: URLRequest) {
        #if DEBUG
        print("📤 Request: \(request.url?.absoluteString ?? "")")
        print("Method: \(request.httpMethod ?? "")")
        print("Headers: \(request.allHTTPHeaderFields ?? [:])")
        #endif
    }
    
    func logResponse(_ response: URLResponse, data: Data) {
        #if DEBUG
        if let httpResponse = response as? HTTPURLResponse {
            print("📥 Response Status: \(httpResponse.statusCode)")
        }
        #endif
    }
    
    func logError(_ error: Error) {
        #if DEBUG
        print("❌ Error: \(error.localizedDescription)")
        #endif
    }
}
