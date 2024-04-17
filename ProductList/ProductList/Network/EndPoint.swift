//
//  EndPoint.swift
//  ProductList
//
//  Created by u2233825 on 05/04/24.
//

import Foundation

protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var header: [String: String]? { get }
    var body: [String: String]? { get }
    var queryItems: [String:String]? { get }
    
}

extension Endpoint {
    var scheme: String {
        return "https"
    }

    var host: String {
        return "dummyjson.com"
    }
}

enum RequestMethod: String {
    case delete = "DELETE"
    case get = "GET"
    case patch = "PATCH"
    case post = "POST"
    case put = "PUT"
}
