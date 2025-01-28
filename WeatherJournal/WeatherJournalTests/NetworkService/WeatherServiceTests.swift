//
//  WeatherServiceTests.swift
//  WeatherJournalTests
//
//  Created by Ganesh Kumar Ananthi Dwarakan on 19/01/25.
//

import Foundation
import XCTest
@testable import WeatherJournal

final class WeatherServiceTests: XCTestCase {
    private var sut: WeatherService!
    private var mockNetwork: MockNetworkService!
    private var mockEnvironment: MockEnvironment!
    
    override func setUp() {
        super.setUp()
        mockNetwork = MockNetworkService()
        mockEnvironment = MockEnvironment()
        sut = WeatherService(
            network: mockNetwork,
            environment: mockEnvironment
        )
    }
    
    override func tearDown() {
        sut = nil
        mockNetwork = nil
        mockEnvironment = nil
        super.tearDown()
    }
    
    func test_fetchWeather_buildsCorrectRequest() async throws {
        // Arrange
        let latitude = 37.7749
        let longitude = -122.4194
        let mockResponse = MockWeatherResponse.create() 
        mockNetwork.mockResult = .success(mockResponse)
        
        // Act
        _ = try await sut.fetchWeather(
            latitude: latitude,
            longitude: longitude
        )
        
        // Assert
        XCTAssertEqual(mockNetwork.executeCallCount, 1)
        XCTAssertEqual(mockNetwork.lastRequest?.path, "/weather")
        
        let queryParams = mockNetwork.lastRequest?.queryParams
        XCTAssertEqual(queryParams?["lat"], String(latitude))
        XCTAssertEqual(queryParams?["lon"], String(longitude))
        XCTAssertEqual(queryParams?["exclude"], "current")
        XCTAssertEqual(queryParams?["appid"], mockEnvironment.apiKey)
    }
    
    func test_fetchWeather_whenNetworkFails() async {
        // Arrange
        let expectedError = HTTPError.serverError(500)
        mockNetwork.mockResult = .failure(expectedError)
        
        // Act & Assert
        do {
            _ = try await sut.fetchWeather(
                latitude: 0,
                longitude: 0
            )
            XCTFail("Expected error to be thrown")
        } catch {
            XCTAssertEqual(error as? HTTPError, expectedError)
        }
    }
    
    func test_fetchWeather_success() async throws {
        // Arrange
        let mockResponse = MockWeatherResponse.create()
        mockNetwork.mockResult = .success(mockResponse)
        
        // Act
        let result = try await sut.fetchWeather(
            latitude: 37.7749,
            longitude: -122.4194
        )
        
        // Assert
        XCTAssertEqual(result.name, "San Francisco")
        XCTAssertEqual(result.coord?.lat, 37.7749)
        XCTAssertEqual(result.coord?.lon, -122.4194)
        XCTAssertEqual(result.weather?.first?.main, "Clear")
        XCTAssertEqual(result.main?.temp, 25.0)
    }
}
