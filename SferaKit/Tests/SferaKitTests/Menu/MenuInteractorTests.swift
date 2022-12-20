//
//  MenuInteractorTests.swift
//  
//
//  Created by Назар Ткаченко on 19.12.2022.
//

import XCTest
@testable import SferaKit

final class MenuInteractorTests: XCTestCase {
    
    func testFetchProductsServiceCalls() {
        let productResponse = Seeds.response
        let productsAPISpy = ProductsAPISpy(response: productResponse)
        let sut = MenuInteractor(presenter: MenuPresenterSpy(), apiService: productsAPISpy, cartService: CartService())
        
        sut.fetchProducts()
        
        XCTAssert(productsAPISpy.fetchCollectionCalled, "fetchProducts() should ask the productsAPISpy to fetch response")
    }
    
    func testLoadProductsServiceCalls() {
        let productResponse = Seeds.response
        let productsAPISpy = ProductsAPISpy(response: productResponse)
        let cartServiceSpy = CartServiceSpy()
        let sut = MenuInteractor(presenter: MenuPresenterSpy(), apiService: productsAPISpy, cartService: cartServiceSpy)
        
        sut.loadProducts()
        
        XCTAssert(cartServiceSpy.loadProductsCalled, "loadProducts() should ask the cartServiceSpy to fetch response")
    }
}
