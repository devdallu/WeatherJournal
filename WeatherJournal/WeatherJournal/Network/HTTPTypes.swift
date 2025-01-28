//
//  HTTPTypes.swift
//  WeatherJournal
//
//  Created by Ganesh Kumar Ananthi Dwarakan on 18/01/25.
//

import Foundation
// MARK: - HTTP Types

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

enum HTTPError: LocalizedError, Equatable {
    
    case invalidURL
    case invalidResponse
    case clientError(Int)
    case serverError(Int)
    case decodingError(Error)
    case networkError(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return String(localized: "Invalid URL configuration.")
        case .invalidResponse:
            return String(localized: "Invalid server response.")
        case .clientError(let code):
            return handleClientError(code: code)
        case .serverError(let code):
            return handleServerError(code: code)
        case .decodingError(let error):
            return String(localized: "Failed to decode response: \(error.localizedDescription)")
        case .networkError(let error):
            return String(localized: "Network error: \(error.localizedDescription)")
        }
    }
    
    private func handleClientError(code: Int) -> String {
        switch code {
        case 400:
            return String(localized: "Bad Request. The server could not understand the request due to invalid syntax.")
        case 401:
            return String(localized: "Unauthorized. Please check your credentials and try again.")
        case 403:
            return String(localized: "Forbidden. You don't have permission to access this resource.")
        case 404:
            return String(localized: "Not Found. The requested resource could not be found.")
        case 405:
            return String(localized: "Method Not Allowed. The request method is not supported for the requested resource.")
        case 408:
            return String(localized: "Request Timeout. The server took too long to respond.")
        case 409:
            return String(localized: "Conflict. The request conflicts with the current state of the server.")
        case 410:
            return String(localized: "Gone. The requested resource is no longer available.")
        case 429:
            return String(localized: "Too Many Requests. You have made too many requests in a short period. Please try again later.")
        default:
            return String(localized: "Client error: \(code). Please check the request and try again.")
        }
    }
    
    private func handleServerError(code: Int) -> String {
        switch code {
        case 500:
            return String(localized: "Internal Server Error. The server encountered an unexpected condition.")
        case 501:
            return String(localized: "Not Implemented. The server does not support the functionality required to fulfill the request.")
        case 502:
            return String(localized: "Bad Gateway. The server received an invalid response from an upstream server.")
        case 503:
            return String(localized: "Service Unavailable. The server is temporarily unable to handle the request. Please try again later.")
        case 504:
            return String(localized: "Gateway Timeout. The server took too long to respond.")
        case 505:
            return String(localized: "HTTP Version Not Supported. The server does not support the HTTP protocol version used in the request.")
        default:
            return String(localized: "Server error: \(code). Please try again later.")
        }
    }
    
    static func ==(lhs: HTTPError, rhs: HTTPError) -> Bool {
           switch (lhs, rhs) {
           case (.invalidURL, .invalidURL),
                (.invalidResponse, .invalidResponse):
               return true
           case (.clientError(let lhsCode), .clientError(let rhsCode)):
               return lhsCode == rhsCode
           case (.serverError(let lhsCode), .serverError(let rhsCode)):
               return lhsCode == rhsCode
           case (.decodingError(let lhsError), .decodingError(let rhsError)):
               return lhsError.localizedDescription == rhsError.localizedDescription
           case (.networkError(let lhsError), .networkError(let rhsError)):
               return lhsError.localizedDescription == rhsError.localizedDescription
           default:
               return false
           }
       }
}
