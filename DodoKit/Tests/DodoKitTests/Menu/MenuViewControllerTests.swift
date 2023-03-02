//
//  MenuViewControllerTests.swift
//  DodoPetProject
//
//  Created by Назар Ткаченко on 20.12.2022.
//

import XCTest
@testable import DodoKit

final class MenuViewControllerTests: XCTestCase {
    
    func testfetchProductsCalls() {
        let tableAdapter = MenuTableAdapter()
        let presenter = MenuPresenterSpy()
        let sut = MenuViewController(rootView: MenuView(tableAdapter: tableAdapter), presenter: presenter)
        sut.presenter = presenter
        
        sut.viewDidLoad()
        
        XCTAssert(presenter.fetchProductsCalled, "fetchedProducts() should ask the MenuPresenterSpy to fetch response")
    }
    
    func testfetchCategoriesCalls() {
        let productResponse = Seeds.response
        let tableAdapter = MenuTableAdapter()
        let presenter = MenuPresenterSpy()
        let sut = MenuViewController(rootView: MenuView(tableAdapter: tableAdapter), presenter: presenter)
        sut.presenter = presenter
        
        sut.updateProducts(productResponse.items)
        
        XCTAssert(presenter.fetchCategoriesCalled, "fetchCategories() should ask the MenuRouterSpy to fetch categories")
    }
}
