//
//  MockRequest.swift
//  WeatherJournalTests
//
//  Created by Ganesh Kumar Ananthi Dwarakan on 19/01/25.
//

import Foundation
import XCTest
@testable import WeatherJournal

struct MockRequest: RequestProtocol {
    let baseURL: String
    let path: String
    let method: HTTPMethod = .get
    let headers: [String: String]? = nil
    let queryParams: [String: String]? = nil
    let body: Data? = nil
}

struct MockResponse: Codable {
    let id: String
}

struct MockBody: Codable {
    let id: String
}
