//
//  ProductModel.swift
//  ProductList
//
//  Created by u2233825 on 05/04/24.
//

import Foundation


struct ProductList: Codable {
    let products: [ProductModel]
}
struct ProductModel: Codable, Equatable {
    let id: Int32
    let title: String?
    let description: String?
    let price: Double?
    let discountPercentage: Double?
    let rating: Double?
    let stock: Int32?
    let brand: String?
    let category: String?
    let thumbnail: String?
    let images: [String]?
    
    init(_ entity: Cart) {
        self.id = entity.id
        self.title = entity.title
        self.description = entity.productDescription
        self.price = entity.price
        self.discountPercentage = entity.discountPercentage
        self.rating = entity.rating
        self.stock = entity.stock
        self.brand = entity.brand
        self.category = entity.category
        self.thumbnail = entity.thumbnail
        if let selectedImage = entity.selectedImage {
            self.images = [selectedImage]
        } else {
            images = nil
        }
    }
    
    /// This is for initializing ProductModel for unit testing
    init(
        id: Int32,
        title: String?,
        description: String?,
        price: Double?,
        discountPercentage: Double?,
        rating: Double?,
        stock: Int32,
        brand: String?,
        category: String?,
        thumbnail: String?,
        images:[String]?
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.price = price
        self.discountPercentage = discountPercentage
        self.rating = rating
        self.stock = stock
        self.brand = brand
        self.category = category
        self.thumbnail = thumbnail
        self.images = images
    }
}
