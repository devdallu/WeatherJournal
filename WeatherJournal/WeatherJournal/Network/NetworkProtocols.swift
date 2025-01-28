//
//  NetworkProtocols.swift
//  WeatherJournal
//
//  Created by Ganesh Kumar Ananthi Dwarakan on 18/01/25.
//

import Foundation
// MARK: - Network Protocols

protocol NetworkRequestable {
    func execute<T: Codable>(_ request: RequestProtocol) async throws -> T
}

protocol NetworkResponseValidating {
    func validate(_ response: HTTPURLResponse, data: Data) throws
}

protocol NetworkLoggable {
    func logRequest(_ request: URLRequest)
    func logResponse(_ response: URLResponse, data: Data)
    func logError(_ error: Error)
}
