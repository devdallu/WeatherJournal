//
//  MockLogger.swift
//  WeatherJournalTests
//
//  Created by Ganesh Kumar Ananthi Dwarakan on 19/01/25.
//

import Foundation
@testable import WeatherJournal

class MockLogger: NetworkLoggable {
    var requestLogs: [URLRequest] = []
    var responseLogs: [(URLResponse, Data)] = []
    var errorLogs: [Error] = []
    
    func logRequest(_ request: URLRequest) {
        requestLogs.append(request)
    }
    
    func logResponse(_ response: URLResponse, data: Data) {
        responseLogs.append((response, data))
    }
    
    func logError(_ error: Error) {
        errorLogs.append(error)
    }
}

