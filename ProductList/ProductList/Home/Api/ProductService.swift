//
//  ProductService.swift
//  AlbertsonsPOC
//
//  Created by u2233825 on 05/04/24.
//

import Foundation

protocol ProductServiceProtocol {
    func getProductList(limit: Int, skip: Int) async -> Result<ProductList, RequestError>
}

struct ProductService: HTTPClient, ProductServiceProtocol {
    func getProductList(limit: Int, skip: Int) async -> Result<ProductList, RequestError> {
        return await sendRequest(endpoint: ProductEndPoint.productList(limit, skip), responseModel: ProductList.self)
    }
}

