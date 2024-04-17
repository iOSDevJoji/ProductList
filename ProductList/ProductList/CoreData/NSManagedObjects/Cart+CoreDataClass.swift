//
//  Cart+CoreDataClass.swift
//  ProductList
//
//  Created by u2233825 on 07/04/24.
//
//

import Foundation
import CoreData

@objc(Cart)
public class Cart: NSManagedObject {

}

extension Cart {
    func update(product: ProductModel) {
        self.id = Int32(product.id)
        self.brand = product.brand
        self.category = product.category
        self.discountPercentage = product.discountPercentage ?? 0
        self.productDescription = product.description
        self.price = product.price ?? 0
        self.selectedImage = product.images?.randomElement()
        self.title = product.title
        self.thumbnail = product.thumbnail
        self.rating = product.rating ?? 0
        self.stock = product.stock ?? 0
    }
}
