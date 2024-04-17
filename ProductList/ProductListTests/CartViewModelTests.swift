//
//  CartViewModelTests.swift
//  ProductListTests
//
//  Created by u2233825 on 10/04/24.
//

import XCTest
@testable import ProductList

final class CartViewModelTests: XCTestCase {
    func makeSut(coredataManager: DataManager = DataManager(.inMemory)) -> CartViewModel {
        CartViewModel(coredataManager: coredataManager)
    }
    
    func testFetchAllProducts() async {
        let coredataManager = DataManager(.inMemory)
        let sut = makeSut(coredataManager: coredataManager)
        await addToCart(coredataManager: coredataManager)
        sut.fetchAllProducts()
        XCTAssertEqual(sut.productModelList?.count, 1)
    }
    
    func testFetchAllProductsEmptyData() {
        let sut = makeSut()
        sut.fetchAllProducts()
        XCTAssertEqual(sut.productModelList?.count, 0)
    }
    
    func testNumberOfProducts() async {
        let coredataManager = DataManager(.inMemory)
        let sut = makeSut(coredataManager: coredataManager)
        await addToCart(coredataManager: coredataManager)
        sut.fetchAllProducts()
        XCTAssertEqual(sut.numberOfProducts, 1)
    }
    
    func testGetProductAtIndex() async throws{
        let coredataManager = DataManager(.inMemory)
        let sut = makeSut(coredataManager: coredataManager)
        await addToCart(coredataManager: coredataManager)
        sut.fetchAllProducts()
        let product = try XCTUnwrap(sut.getProduct(at: 0))
        XCTAssertEqual(product, getProductModel())
    }
}

/// Mock data
extension CartViewModelTests {
    func addToCart(coredataManager: DataManager) async {
        let context = coredataManager.persistentContainer.viewContext
        let cartEntity = Cart(context: context)
        cartEntity.update(product: getProductModel())
        do {
            try context.save()
        } catch {
            print("error-Saving data")
        }
    }
    
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
