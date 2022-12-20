//
//  MenuViewControllerTests.swift
//  
//
//  Created by Назар Ткаченко on 20.12.2022.
//

import XCTest
@testable import SferaKit

final class MenuViewControllerTests: XCTestCase {
    
    func testfetchProductsCalls() {
        let tableAdapter = MenuTableAdapter()
        let sut = MenuViewController(tableAdapter: tableAdapter)
        let presenter = MenuPresenterSpy()
        sut.presenter = presenter
        
        sut.viewDidLoad()
        
        XCTAssert(presenter.fetchProductsCalled, "fetchedProducts() should ask the MenuPresenterSpy to fetch response")
    }
    
    func testfetchCategoriesCalls() {
        let productResponse = Seeds.response
        let tableAdapter = MenuTableAdapter()
        let sut = MenuViewController(tableAdapter: tableAdapter)
        let presenter = MenuPresenterSpy()
        sut.presenter = presenter
        
        sut.updateProducts(productResponse.items)
        
        XCTAssert(presenter.fetchCategoriesCalled, "fetchCategories() should ask the MenuRouterSpy to fetch categories")
    }
    
    func testShouldDisplayTableAdapterReloadData() {
        let productResponse = Seeds.response
        let tableview = TableViewSpy()
        let sut = MenuViewController(tableAdapter: MenuTableAdapter())
        let presenter = MenuPresenterSpy()
        sut.presenter = presenter
        sut.tableView = tableview
        
        sut.updateProducts(productResponse.items)
        XCTAssert(tableview.reloadDataCalled, "Displaying fetched products should reload the table view")
        tableview.reloadDataCalled = false
        
        sut.updateCategories(productResponse.categories)
        XCTAssert(tableview.reloadDataCalled, "Displaying fetched products should reload the table view")
        tableview.reloadDataCalled = false
        
        sut.updateBanners(productResponse.banners)
        XCTAssert(tableview.reloadDataCalled, "Displaying fetched products should reload the table view")

    }
}
