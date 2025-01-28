//
//  NetworkService.swift
//  WeatherJournal
//
//  Created by Ganesh Kumar Ananthi Dwarakan on 18/01/25.
//

import Foundation

final class NetworkService: NetworkRequestable {
    private let session: URLSessionProtocol
    private lazy var validator: NetworkResponseValidating = DefaultValidator()
    private lazy var logger: NetworkLoggable? = DefaultLogger()
    
    init(
        session: URLSessionProtocol = URLSession.shared,
        validator: NetworkResponseValidating? = nil,
        logger: NetworkLoggable? = nil
    ) {
        self.session = session
        if let validator = validator {
            self.validator = validator
        }
        if let logger = logger {
            self.logger = logger
        }
    }
    
    func execute<T: Codable>(_ request: RequestProtocol) async throws -> T {
        let urlRequest = try createURLRequest(from: request)
        logger?.logRequest(urlRequest)
        
        do {
            let (data, response) = try await session.data(for: urlRequest)
            logger?.logResponse(response, data: data)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw HTTPError.invalidResponse
            }
            
            try validator.validate(httpResponse, data: data)
            
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch let error as DecodingError {
            logger?.logError(error)
            throw HTTPError.decodingError(error)
        } catch {
            logger?.logError(error)
            throw HTTPError.networkError(error)
        }
    }
    
    func execute(_ request: RequestProtocol) async throws {
        let urlRequest = try createURLRequest(from: request)
        let (data, response) = try await session.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw HTTPError.invalidResponse
        }
        
        try validator.validate(httpResponse, data: data)
    }
    
    private func createURLRequest(from request: RequestProtocol) throws -> URLRequest {
        guard var components = URLComponents(string: request.baseURL + request.path) else {
            throw HTTPError.invalidURL
        }
        
        if let params = request.queryParams {
            components.queryItems = params.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        
        guard let url = components.url else {
            throw HTTPError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.headers
        urlRequest.httpBody = request.body
        urlRequest.timeoutInterval = 30.0
        
        return urlRequest
    }
}
