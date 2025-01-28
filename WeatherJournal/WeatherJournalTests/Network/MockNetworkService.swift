//
//  MockNetworkService.swift
//  WeatherJournalTests
//
//  Created by Ganesh Kumar Ananthi Dwarakan on 19/01/25.
//

import Foundation
@testable import WeatherJournal

class MockNetworkService: NetworkRequestable {
    var executeCallCount = 0
    var lastRequest: RequestProtocol?
    var mockResult: Result<WeatherResponse, Error>?
    
    func execute<T: Codable>(_ request: RequestProtocol) async throws -> T {
        executeCallCount += 1
        lastRequest = request
        
        guard let mockResult else {
            throw HTTPError.invalidResponse
        }
        
        switch mockResult {
        case .success(let response):
            return response as! T
        case .failure(let error):
            throw error
        }
    }
}
