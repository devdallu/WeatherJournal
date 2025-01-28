//
//  APIBuilderTests.swift
//  WeatherJournalTests
//
//  Created by Ganesh Kumar Ananthi Dwarakan on 19/01/25.
//

import Foundation
import XCTest
@testable import WeatherJournal

final class APIBuilderTests: XCTestCase {
    private var sut: APIBuilder!
    private var mockEnvironment: MockEnvironment!
    
    override func setUp() {
        super.setUp()
        mockEnvironment = MockEnvironment()
        sut = APIBuilder(
            environment: mockEnvironment,
            path: "/weather"
        )
    }
    
    override func tearDown() {
        sut = nil
        mockEnvironment = nil
        super.tearDown()
    }
    
    func test_addQueryParameters_updatesRequest() {
        // Arrange
        let params = ["key": "value"]
        
        // Act
        let request = sut
            .addQueryParameters(params)
            .build()
        
        // Assert
        XCTAssertEqual(request.queryParams?["key"], "value")
    }
    
    func test_addHeaders_mergesWithDefaultHeaders() {
        // Arrange
        let headers = ["Custom-Header": "value"]
        
        // Act
        let request = sut
            .addHeaders(headers)
            .build()
        
        // Assert
        XCTAssertEqual(request.headers?["Custom-Header"], "value")
        XCTAssertEqual(request.headers?["Content-Type"], "application/json")
    }
    
    func test_addBody_encodesDataCorrectly() throws {
        // Arrange
        let mockBody = MockBody(id: "test")
        
        // Act
        let request = try sut
            .addBody(mockBody)
            .build()
        
        // Assert
        XCTAssertNotNil(request.body)
    }
}
