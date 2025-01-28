//
//  URLSessionProtocol.swift
//  WeatherJournal
//
//  Created by Ganesh Kumar Ananthi Dwarakan on 19/01/25.
//

import Foundation

protocol URLSessionProtocol {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol { }
