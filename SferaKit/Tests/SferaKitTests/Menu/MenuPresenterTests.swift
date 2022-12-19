//
//  MenuPresenterTests.swift
//  
//
//  Created by Назар Ткаченко on 12.12.2022.
//

import XCTest
@testable import SferaKit

final class MenuPresenterTests: XCTestCase {
    
//    func testFetchProductsServiceCalls() {
//        let productResponse = Seeds.response
//        let productsAPISpy = ProductsAPISpy(response: productResponse)
//        let sut = MenuInteractor(presenter: PresenterSpy(), apiService: productsAPISpy, cartService: CartService())
//
//        sut.fetchProducts()
//
//        XCTAssert(productsAPISpy.fetchCollectionCalled, "fetchProducts() should ask the productsAPISpy to fetch response")
//    }
    func testfetchedProductsFromInteractorCalls() {
        let view = ViewSpy()
        let router = RouterSpy()
        let sut = MenuPresenter(view: view, router: router)
        
        sut.fetchedProducts(<#T##data: ProductsResponse##ProductsResponse#>)
        
        XCTAssert( , "fetchProducts() should ask the productsAPISpy to fetch response")
    }
}
