//
//  CartViewModel.swift
//  ProductList
//
//  Created by u2233825 on 08/04/24.
//

import Foundation

class CartViewModel {
    private let coredataManager: DataManager
    var productModelList: [ProductModel]?
    
    init(coredataManager: DataManager = DataManager()) {
        self.coredataManager = coredataManager
        fetchAllProducts()
    }
    
    var numberOfProducts: Int {
        return productModelList?.count ?? 0
    }
    
    func getProduct(at index: Int) -> ProductModel? {
        return productModelList?[safe: index]
    }
}

/// Coredata functions
extension CartViewModel {
    func fetchAllProducts() {
        let context = coredataManager.persistentContainer.viewContext
        let fetchRequest = Cart.fetchRequest()
        do {
            productModelList = try context.fetch(fetchRequest).map(ProductModel.init)
        } catch {
            print("error-Fetching data")
        }
    }
}
