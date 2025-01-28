//
//  DefaultValidator.swift
//  WeatherJournal
//
//  Created by Ganesh Kumar Ananthi Dwarakan on 18/01/25.
//

import Foundation

struct DefaultValidator: NetworkResponseValidating {
    func validate(_ response: HTTPURLResponse, data: Data) throws {
        switch response.statusCode {
        case 200...299: return
        case 400...499: throw HTTPError.clientError(response.statusCode)
        case 500...599: throw HTTPError.serverError(response.statusCode)
        default: throw HTTPError.clientError(response.statusCode)
        }
    }
}
