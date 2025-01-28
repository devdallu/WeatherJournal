//
//  APIRequest.swift
//  WeatherJournal
//
//  Created by Ganesh Kumar Ananthi Dwarakan on 18/01/25.
//

import Foundation

struct APIRequest: RequestProtocol {
    let baseURL: String
    let path: String
    let method: HTTPMethod
    var headers: [String: String]?
    var queryParams: [String: String]?
    var body: Data?
    
    init(
        baseURL: String,
        path: String,
        method: HTTPMethod = .get,
        headers: [String: String]? = nil,
        queryParams: [String: String]? = nil,
        body: Data? = nil
    ) {
        self.baseURL = baseURL
        self.path = path
        self.method = method
        self.headers = headers
        self.queryParams = queryParams
        self.body = body
    }
}
