//
//  HomeViewModelTests.swift
//  ProductListTests
//
//  Created by u2233825 on 09/04/24.
//

import XCTest
@testable import ProductList

final class HomeViewModelTests: XCTestCase {
    
    func makeSut(
        mockRepo: ProductServiceProtocol = MockProductRepository()
    ) -> HomeViewModel {
        HomeViewModel(productRepository: mockRepo)
    }
    
    
    func testGetProductListSuccess() async {
        let mockRepo = MockProductRepository()
        mockRepo.responseType = .success
        let sut = makeSut(mockRepo: mockRepo)
        let error = await sut.getProductList()
        XCTAssertTrue(sut.productModelList?.count == 2)
        XCTAssertNil(error)
    }
    
    func testGetProductListFailure() async {
        let mockRepo = MockProductRepository()
        mockRepo.responseType = .failure
        let sut = makeSut(mockRepo: mockRepo)
        let error = await sut.getProductList()
        XCTAssertNil(sut.productModelList)
        XCTAssertNotNil(error)
    }
    
    func testNumberOfProducts() async {
        let mockRepo = MockProductRepository()
        mockRepo.responseType = .success
        let sut = makeSut(mockRepo: mockRepo)
        _ = await sut.getProductList()
        XCTAssertEqual(sut.numberOfProducts, 2)
    }
    
    func testGetProduct() async {
        let mockRepo = MockProductRepository()
        mockRepo.responseType = .success
        let sut = makeSut(mockRepo: mockRepo)
        _ = await sut.getProductList()
        XCTAssertEqual(
            sut.getProduct(at: 1),
            ProductModel(
            id: 2,
            title: "Product2",
            description: "Test product2",
            price: 20,
            discountPercentage: 0.5,
            rating: 4,
            stock: 5,
            brand: "Test2",
            category: "category2",
            thumbnail: "https://product2.png",
            images: ["https://product2.png"]
        ))
    }
}



class MockProductRepository: ProductServiceProtocol {
    var responseType: ResponseType = .success
    func getProductList(limit: Int, skip: Int) async -> Result<ProductList, RequestError> {
        switch responseType {
        case .success:
            return .success(self.getMockProductList())
        case .failure:
            return .failure(RequestError.unknown)
        }
    }
    
    func getMockProductList() -> ProductList {
        ProductList(products: [
            ProductModel(
                id: 1,
                title: "Product1",
                description: "Test product1",
                price: 10,
                discountPercentage: 0.5,
                rating: 3,
                stock: 4,
                brand: "Test1",
                category: "category1",
                thumbnail: "https://product1.png",
                images: ["https://product1.png"]
            ),
            ProductModel(
                id: 2,
                title: "Product2",
                description: "Test product2",
                price: 20,
                discountPercentage: 0.5,
                rating: 4,
                stock: 5,
                brand: "Test2",
                category: "category2",
                thumbnail: "https://product2.png",
                images: ["https://product2.png"]
            )
        ]
        )
    }
    
}


/// For Unit Testing
enum ResponseType {
    case success
    case failure
}
