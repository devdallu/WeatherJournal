//
//  NetworkServiceTests.swift
//  WeatherJournalTests
//
//  Created by Ganesh Kumar Ananthi Dwarakan on 19/01/25.
//

import XCTest
@testable import WeatherJournal

final class NetworkServiceTests: XCTestCase {
    private var sut: NetworkService!
    private var mockSession: MockURLSession!
    private var mockValidator: MockValidator!
    private var mockLogger: MockLogger!
    private var mockEnivornment: MockEnvironment!
    
    override func setUp() {
        super.setUp()
        mockSession = MockURLSession()
        mockValidator = MockValidator()
        mockLogger = MockLogger()
        mockEnivornment = MockEnvironment()
        sut = NetworkService(
            session: mockSession as URLSessionProtocol,
            validator: mockValidator,
            logger: mockLogger
        )
    }
    
    override func tearDown() {
        sut = nil
        mockSession = nil
        mockValidator = nil
        mockLogger = nil
        mockEnivornment = nil
        super.tearDown()
    }
    
    func test_execute_whenRequestIsValid_returnsDecodedResponse() async throws {
        // Arrange
        let mockResponseData = """
        {
            "coord": {
                "lon": 153.0095,
                "lat": -27.4522
            },
            "weather": [{
                "id": 802,
                "main": "Clouds",
                "description": "scattered clouds",
                "icon": "03n"
            }],
            "base": "stations",
            "main": {
                "temp": 297.03,
                "feels_like": 297.59,
                "temp_min": 296.35,
                "temp_max": 297.81,
                "pressure": 1015,
                "humidity": 81,
                "sea_level": 1015,
                "grnd_level": 1009
            },
            "visibility": 10000,
            "wind": {
                "speed": 4.63,
                "deg": 360
            },
            "clouds": {
                "all": 40
            },
            "dt": 1738069431,
            "sys": {
                "type": 2,
                "id": 2005393,
                "country": "AU",
                "sunrise": 1738005435,
                "sunset": 1738053853
            },
            "timezone": 36000,
            "id": 2177560,
            "name": "Ashgrove",
            "cod": 200
        }
        """.data(using: .utf8)!
        
        let mockHttpResponse = HTTPURLResponse(
            url: URL(string: mockEnivornment.baseURL)!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )!
        
        mockSession.mockData = mockResponseData
        mockSession.mockResponse = mockHttpResponse
        
        // Act
        let response: WeatherResponse = try await sut.execute(
            APIRequest(
                baseURL: mockEnivornment.baseURL,
                path: "/weather"
            )
        )
        
        // Assert
        XCTAssertEqual(response.coord?.lon, 153.0095)
        XCTAssertEqual(response.coord?.lat, -27.4522)
        XCTAssertEqual(mockLogger.requestLogs.count, 1)
        XCTAssertEqual(mockLogger.responseLogs.count, 1)
    }
    
    func test_execute_whenNetworkFails_throwsError() async {
        // Arrange
        let expectedError = NSError(domain: "weather", code: -1)
        mockSession.mockError = expectedError
        
        // Act & Assert
        do {
            let _: WeatherResponse = try await sut.execute(
                APIRequest(
                    baseURL: mockEnivornment.baseURL,
                    path: "/weather"
                )
            )
            XCTFail("Expected error to be thrown")
        } catch let error as HTTPError {
            XCTAssertEqual(mockLogger.errorLogs.count, 1)
            if case .networkError(let networkError) = error {
                XCTAssertEqual((networkError as NSError).domain, expectedError.domain)
                XCTAssertEqual((networkError as NSError).code, expectedError.code)
            } else {
                XCTFail("Expected networkError but got \(error)")
            }
        } catch {
            XCTFail("Unexpected error type: \(error)")
        }
    }
    
    func test_execute_whenValidationFails_throwsError() async {
        // Arrange
        mockValidator.shouldThrowError = true
        mockSession.mockResponse = HTTPURLResponse(
            url: URL(string: mockEnivornment.baseURL)!,
            statusCode: 400,
            httpVersion: nil,
            headerFields: nil
        )
        
        // Act & Assert
        do {
            let _: WeatherResponse = try await sut.execute(
                APIRequest(
                    baseURL: mockEnivornment.baseURL,
                    path: "/test"
                )
            )
            XCTFail("Expected validation error")
        } catch {
            XCTAssertTrue(error is HTTPError)
            XCTAssertEqual(mockLogger.errorLogs.count, 1)
        }
    }
}
