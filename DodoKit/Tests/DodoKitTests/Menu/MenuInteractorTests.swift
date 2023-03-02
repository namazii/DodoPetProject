//
//  MenuInteractorTests.swift
//  DodoPetProject
//
//  Created by Назар Ткаченко on 19.12.2022.
//

import XCTest
@testable import DodoKit

final class MenuInteractorTests: XCTestCase {
    
    func testFetchProductsServiceCalls() {
        let productsAPISpy = ProductsAPISpy()
        let sut = MenuInteractor(apiService:  productsAPISpy)
        
        sut.fetchProducts()
        sleep(1)

        XCTAssert(productsAPISpy.fetchCollectionCalled, "fetchProducts() should ask the productsAPISpy to fetch response")
    }
    
    func testLoadProductsServiceCalls() {
        let productsAPISpy = ProductsAPISpy()
        let cartServiceSpy = CartServiceSpy()
        let sut = MenuInteractor(apiService: productsAPISpy, cartService: cartServiceSpy)

        sut.loadProducts()        

        XCTAssert(cartServiceSpy.loadProductsCalled, "loadProducts() should ask the cartServiceSpy to fetch response")
    }
}
