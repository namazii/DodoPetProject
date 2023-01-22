//
//  MenuPresenterTests.swift
//  DodoPetProject
//
//  Created by Назар Ткаченко on 12.12.2022.
//

import XCTest
@testable import SferaKit

final class MenuPresenterTests: XCTestCase {
    
    func testfetchedProductsFromInteractorCalls() {
        let productResponse = Seeds.response
        let view = MenuViewSpy()
        let router = MenuRouterSpy()
        let sut = MenuPresenter(view: view, router: router)
        
        sut.fetchedProducts(productResponse)
        
        XCTAssert(view.updateBannersCalled , "fetchedProducts() should ask the ViewSpy to fetch response")
        XCTAssert(view.updateProductsCalled, "fetchedProducts() should ask the ViewSpy to fetch response")
    }
    
    func testTakeIDSelectedItemFromTableViewCell() {
        let productResponse = Seeds.response
        let view = MenuViewSpy()
        let router = MenuRouterSpy()
        let sut = MenuPresenter(view: view, router: router)
        
        sut.products = productResponse.items
        sut.itemSelected(index: 0)
        
        XCTAssert(router.showProductDetailCalled , "itemSelected() should ask the RouterSpy to fetch response")
    }
    
    func testFetchCategoriesCalls() {
        let productResponse = Seeds.response
        let view = MenuViewSpy()
        let router = MenuRouterSpy()
        let sut = MenuPresenter(view: view, router: router)
        
        sut.products = productResponse.items
        sut.fetchCategories()
        
        XCTAssert(view.updateCategoriesCalled , "fetchCategories() should ask the ViewSpy to fetch response")
        XCTAssertNotNil(view.updateCategoriesItems, "fetchCategories() should provide items to ViewSpy")
    }
    
    func testfetchProductsFromInteractorCalls() {
        let view = MenuViewSpy()
        let router = MenuRouterSpy()
        let interactor = MenuInteractorSpy()
        let sut = MenuPresenter(view: view, router: router)
        sut.interactor = interactor
        
        sut.fetchProducts()
        
        XCTAssert(interactor.fetchProductsCalled, "fetchProducts() should ask the MenuInteractorSpy to fetch response")
        XCTAssert(interactor.loadProductsCalled, "fetchProducts() should ask the MenuInteractorSpy to fetch response")
    }
}
