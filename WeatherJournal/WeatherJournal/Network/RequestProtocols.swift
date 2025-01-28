//
//  RequestConfigurable.swift
//  WeatherJournal
//
//  Created by Ganesh Kumar Ananthi Dwarakan on 19/01/25.
//

import Foundation

protocol RequestConfigurable {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
}

protocol RequestModifiable {
    var headers: [String: String]? { get }
    var queryParams: [String: String]? { get }
    var body: Data? { get }
}

protocol RequestProtocol: RequestConfigurable & RequestModifiable {}

extension RequestProtocol {
    var headers: [String: String ]? { return nil}
    var queryParam: [String : String]? { return nil}
    var body: Data? { nil }
}
