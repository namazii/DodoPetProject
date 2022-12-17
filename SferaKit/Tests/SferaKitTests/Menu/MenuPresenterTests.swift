//
//  MenuPresenterTests.swift
//  
//
//  Created by Назар Ткаченко on 12.12.2022.
//

import XCTest
@testable import SferaKit

final class MenuPresenterTests: XCTestCase {

    private var viewController: MenuViewController?
    private var presenter: MenuPresenter?
    
    override func setUp() {
        super.setUp()
        viewController = MenuAssembly().configure()
        presenter = viewController?.presenter as? MenuPresenter
    }

    override func tearDown() {
        presenter = nil
        viewController = nil
        super.tearDown()
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
