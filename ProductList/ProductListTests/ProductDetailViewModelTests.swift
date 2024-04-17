//
//  ProductDetailViewModelTests.swift
//  ProductListTests
//
//  Created by u2233825 on 09/04/24.
//

import XCTest
@testable import ProductList

final class ProductDetailViewModelTests: XCTestCase {
    
    func makeSut(product: ProductModel) -> ProductDetailViewModel {
        ProductDetailViewModel(product: product, coredataManager: DataManager(.inMemory))
    }
    
    func testAddToCart() async {
        let sut = makeSut(product: getProductModel())
        let result = await sut.addToCart()
        XCTAssertTrue(result)
    }
    
    func testFetchProductFromCart() async {
        let sut = makeSut(product: getProductModel())
        let result = await sut.addToCart()
        XCTAssertTrue(result)
        let cart = await sut.fetchProductFromCart(product: getProductModel())
        XCTAssertNotNil(cart)
        XCTAssertEqual(cart?.id, 1)
    }
    
    func testFetchProductFromCartFailure() async {
        let sut = makeSut(product: getProductModel())
        let cart = await sut.fetchProductFromCart(product: getProductModel())
        XCTAssertNil(cart)
    }
        
    func testAllProductProperties() {
        let sut = makeSut(product: getProductModel())
        XCTAssertNotNil(sut.headerImageUrl)
        XCTAssertEqual(sut.brand, "Test1")
        XCTAssertEqual(sut.productCategory, "category1")
        XCTAssertEqual(sut.productDescription, "Test product1")
        XCTAssertEqual(sut.productDiscountPercentage, "0.5")
        XCTAssertEqual(sut.productPrice, "10.0")
        XCTAssertEqual(sut.title, "Product1")
    }
}

// This is for mock data
extension ProductDetailViewModelTests {
    func getProductModel() -> ProductModel {
        ProductModel(
            id: 1,
            title: "Product1",
            description: "Test product1",
            price: 10.0,
            discountPercentage: 0.5,
            rating: 3,
            stock: 4,
            brand: "Test1",
            category: "category1",
            thumbnail: "https://product1.png",
            images: ["https://product1.png"]
        )
    }
}

