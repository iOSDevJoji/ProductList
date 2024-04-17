//
//  ProductDetailViewModel.swift
//  ProductList
//
//  Created by u2233825 on 07/04/24.
//

import Foundation
import CoreData

class ProductDetailViewModel {
    
    private let product: ProductModel
    private let coredataManager: DataManager
    
    init(product: ProductModel, coredataManager: DataManager = DataManager()) {
        self.product = product
        self.coredataManager = coredataManager
    }
    
    var headerImageUrl: String? {
        product.images?.randomElement()
    }
    
    var title: String? {
        product.title
    }
    
    var productDescription: String {
        product.description ?? ""
    }
    
    var productDiscountPercentage: String {
        product.discountPercentage?.stringValue ?? ""
    }
    
    var brand: String {
        product.brand ?? ""
    }
    
    var productCategory: String {
        product.category ?? ""
    }
    
    var productPrice: String {
        product.price?.stringValue ?? ""
    }
    
}
/// Coredata functions
extension ProductDetailViewModel {
    func addToCart() async -> Bool {
        guard await fetchProductFromCart(product: product) == nil else {
            return true
        }
        let context = coredataManager.persistentContainer.viewContext
        let cartEntity = Cart(context: context)
        cartEntity.update(product: product)
        do {
            try context.save()
            return true
        } catch {
            return false
        }
    }
    
    func fetchProductFromCart(product: ProductModel) async -> Cart? {
        let context = coredataManager.persistentContainer.viewContext
        let fetchRequest = Cart.fetchRequest()
        fetchRequest.predicate =  NSPredicate(format: "id == %d", product.id)
        do {
            let product = try context.fetch(fetchRequest)
            return product.first
        } catch {
            return nil
        }
    }
}
