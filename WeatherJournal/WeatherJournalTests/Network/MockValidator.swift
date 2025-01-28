//
//  MockValidator.swift
//  WeatherJournalTests
//
//  Created by Ganesh Kumar Ananthi Dwarakan on 19/01/25.
//

import Foundation
@testable import WeatherJournal

class MockValidator: NetworkResponseValidating {
    var shouldThrowError = false
    
    func validate(_ response: HTTPURLResponse, data: Data) throws {
        if shouldThrowError {
            throw HTTPError.clientError(response.statusCode)
        }
    }
}
