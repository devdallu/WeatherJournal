//
//  APIBuilder.swift
//  WeatherJournal
//
//  Created by Ganesh Kumar Ananthi Dwarakan on 18/01/25.
//

import Foundation

final class APIBuilder {
    private var request: APIRequest
    
    init(
        environment: Environment,
        path: String,
        method: HTTPMethod = .get
    ) {
        self.request = APIRequest(
            baseURL: environment.baseURL,
            path: path,
            method: method,
            headers: environment.defaultHeaders
        )
    }
    
    @discardableResult
    func addQueryParameters(
        _ params: [String: String]?
    ) -> Self {
        request = APIRequest(
            baseURL: request.baseURL,
            path: request.path,
            method: request.method,
            headers: request.headers,
            queryParams: params,
            body: request.body
        )
        return self
    }
    
    @discardableResult
    func addHeaders(
        _ headers: [String: String]?
    ) -> Self {
        var updatedHeaders = request.headers ?? [:]
        headers?
            .forEach {
                updatedHeaders[$0.key] = $0.value
            }
        
        request = APIRequest(
            baseURL: request.baseURL,
            path: request.path,
            method: request.method,
            headers: updatedHeaders,
            queryParams: request.queryParams,
            body: request.body
        )
        return self
    }
    
    @discardableResult
    func addBody<T: Encodable>(
        _ body: T
    ) throws -> Self {
        let data = try JSONEncoder().encode(
            body
        )
        request = APIRequest(
            baseURL: request.baseURL,
            path: request.path,
            method: request.method,
            headers: request.headers,
            queryParams: request.queryParams,
            body: data
        )
        return self
    }
    
    func build() -> RequestProtocol {
        return request
    }
}
