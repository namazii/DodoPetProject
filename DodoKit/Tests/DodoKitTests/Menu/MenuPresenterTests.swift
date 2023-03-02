//
//  MenuPresenterTests.swift
//  DodoPetProject
//
//  Created by Назар Ткаченко on 12.12.2022.
//

import XCTest
@testable import DodoKit
final class MenuPresenterTests: XCTestCase {
    
    func testTakeIDSelectedItemFromTableViewCell() {
        let productResponse = Seeds.response
        let interactor = MenuInteractorSpy()
        let router = MenuRouterSpy()
        let sut = MenuPresenter(interactor: interactor, router: router)
        
        sut.products = productResponse.items
        sut.itemSelected(index: 0)
        
        XCTAssert(router.showProductDetailCalled , "itemSelected() should ask the RouterSpy to fetch response")
    }
    
    func testfetchProductsFromInteractorCalls() {
        let router = MenuRouterSpy()
        let interactor = MenuInteractorSpy()
        let sut = MenuPresenter(interactor: interactor, router: router)
        sut.interactor = interactor
        
        sut.fetchProducts()
        
        XCTAssert(interactor.fetchProductsCalled, "fetchProducts() should ask the MenuInteractorSpy to fetch response")
        XCTAssert(interactor.loadProductsCalled, "fetchProducts() should ask the MenuInteractorSpy to fetch response")
    }
}
