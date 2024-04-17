//
//  HomeViewModel.swift
//  ProductList
//
//  Created by u2233825 on 05/04/24.
//

import Foundation

class HomeViewModel {
    
    private var limitValue: Int = 10
    private var skipValue: Int = 0
    private var productRepository: ProductServiceProtocol
    var productModelList: [ProductModel]?
    
    init(
        productRepository: ProductServiceProtocol = ProductService()
    ) {
        self.productRepository = productRepository
    }
    
    var numberOfProducts: Int {
        return productModelList?.count ?? 0
    }
    
    func getProduct(at index: Int) -> ProductModel? {
        return productModelList?[index]
    }
    
    func getProductList() async -> RequestError? {
        skipValue = skipValue + 10
        let result = await productRepository.getProductList(limit: limitValue, skip: skipValue)
        switch result {
        case .success(let productResponse):
            if productModelList != nil {
                productModelList?.append(contentsOf: productResponse.products)
            } else {
                productModelList = productResponse.products
            }
            return nil
        case .failure(let error):
            return error
        }
    }
}
