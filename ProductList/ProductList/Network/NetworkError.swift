//
//  NetworkError.swift
//  ProductList
//
//  Created by u2233825 on 05/04/24.
//

import Foundation

enum RequestError: Error {
    case decode
    case invalidURL
    case noResponse
    case unauthorized
    case unexpectedStatusCode
    case internalServerError
    case unknown
    
    var customMessage: String {
        switch self {
        case .decode:
            return "Decode error"
        case .unauthorized:
            return "Session expired"
        case .internalServerError:
            return "Internal server error"
        default:
            return "Unknown error"
        }
    }
}
