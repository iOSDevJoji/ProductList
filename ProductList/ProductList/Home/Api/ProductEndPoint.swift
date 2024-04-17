//
//  ProductEndPoint.swift
//  ProductList
//
//  Created by u2233825 on 05/04/24.
//

import Foundation

enum ProductEndPoint {
    case productList(Int, Int)
    case productDetail
}

extension ProductEndPoint: Endpoint {
    var queryItems: [String : String]? {
        switch self {
        case .productList(let limit, let skip):
            return [
                "limit": limit.stringValue,
                "skip": skip.stringValue
            ]
        default:
            return nil
        }
    }
    
    var path: String {
        switch self {
        case .productList(_, _):
            return "/products/"
        default:
            return ""
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .productList:
            return .get
        default:
            return .get
        }
    }
    
    var header: [String : String]? {
        return [
            "Content-Type": "application/json"
        ]
    }
    
    var body: [String : String]? {
        return nil
    }
    
    
}
