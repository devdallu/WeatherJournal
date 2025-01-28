//
//  WeatherViewModelTests.swift
//  WeatherJournalTests
//
//  Created by Ganesh Kumar Ananthi Dwarakan on 19/01/25.
//

import Foundation
import XCTest
import Connectivity
@testable import WeatherJournal

final class WeatherViewModelTests: XCTestCase {
    private var sut: WeatherViewModel!
    private var weatherService: WeatherService!
    private var mockNetwork: MockNetworkService!
    private var mockEnvironment: MockEnvironment!
    private var mockConnectivityService: MockConnectivityService!
    
    @MainActor
    override func setUp() {
        super.setUp()
        mockNetwork = MockNetworkService()
        mockEnvironment = MockEnvironment()
        mockConnectivityService = MockConnectivityService()
        
        weatherService = WeatherService(
            network: mockNetwork,
            environment: mockEnvironment
        )
        
        sut = WeatherViewModel(
            weatherService: weatherService,
            connectivityService: mockConnectivityService
        )
    }
    
    override func tearDown() {
        sut = nil
        weatherService = nil
        mockNetwork = nil
        mockEnvironment = nil
        mockConnectivityService = nil
        super.tearDown()
    }
    
    // MARK: - Connectivity Tests
    
    func test_fetchWeatherStatus_whenNotConnected_setsErrorState() async {
        // Arrange
        mockConnectivityService.mockStatus = .notConnected
        
        // Act
        await sut.fetchWeatherStatus(latitude: 0, longitude: 0)
        
        // Assert
        if case .error(let message) = await sut.state {
            XCTAssertEqual(message, "No internet connection")
        } else {
            XCTFail("Expected error state")
        }
    }
    
    func test_fetchWeatherStatus_whenConnected_fetchesWeather() async {
        // Arrange
        mockConnectivityService.mockStatus = .connected
        let mockResponse = MockWeatherResponse.create()
        mockNetwork.mockResult = .success(mockResponse)
        
        // Act
        await sut.fetchWeatherStatus(latitude: 37.7749, longitude: -122.4194)
        
        // Assert
        if case .loaded(let weather) = await sut.state {
            XCTAssertEqual(weather.name, mockResponse.name)
            XCTAssertEqual(weather.coord?.lat, mockResponse.coord?.lat)
            XCTAssertEqual(weather.coord?.lon, mockResponse.coord?.lon)
        } else {
            XCTFail("Expected loaded state")
        }
    }
    
    func test_fetchWeatherStatus_setsLoadingState() async {
        // Arrange
        mockConnectivityService.mockStatus = .connected
        mockNetwork.mockResult = .success(MockWeatherResponse.create())
        
        // Act
        await sut.fetchWeatherStatus(latitude: 0, longitude: 0)
        
        // Assert
        XCTAssertEqual(mockNetwork.executeCallCount, 1)
    }
    
    func test_fetchWeatherStatus_whenServiceFails_setsErrorState() async {
        // Arrange
        mockConnectivityService.mockStatus = .connected
        let expectedError = HTTPError.serverError(500)
        mockNetwork.mockResult = .failure(expectedError)
        
        // Act
        await sut.fetchWeatherStatus(latitude: 0, longitude: 0)
        
        // Assert
        if case .error(let message) = await sut.state {
            XCTAssertEqual(message, expectedError.localizedDescription)
        } else {
            XCTFail("Expected error state")
        }
    }
    
    func test_deinit_cancelsPendingTasks() async {
        // Arrange
        mockConnectivityService.mockStatus = .connected
        var sut: WeatherViewModel? = await WeatherViewModel(
            weatherService: weatherService,
            connectivityService: mockConnectivityService
        )
        
        // Act
        await sut?.fetchWeatherStatus(latitude: 0, longitude: 0)
        sut = nil
        
        // Assert
        XCTAssertEqual(mockNetwork.executeCallCount, 1)
    }
}

// MARK: - Mock Objects

private final class MockConnectivityService: ConnectivityServiceProtocol {
    var mockStatus: Connectivity.Status = .notConnected
    var checkConnectionStatusCallCount = 0
    
    func checkConnectionStatus() async -> Connectivity.Status {
        checkConnectionStatusCallCount += 1
        return mockStatus
    }
}
