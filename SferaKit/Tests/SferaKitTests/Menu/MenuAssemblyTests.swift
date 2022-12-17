//
//  MenuAssemblyTests.swift
//  
//
//  Created by Назар Ткаченко on 12.12.2022.
//

import XCTest
@testable import SferaKit

final class MenuAssemblyTests: XCTestCase {

    private var viewController: MenuViewController?

    override func setUp() {
        super.setUp()
        viewController = MenuAssembly().configure()
    }
    
    override func tearDown() {
        viewController = nil
        super.tearDown()
    }
    
    func testViewOutput() {
        XCTAssertNotNil(viewController?.presenter, "MenuPresenter is nil after configuration")
        XCTAssertTrue(viewController?.presenter is MenuPresenter, "Presetner is not MenuPresenter")
    }
    
    func testViewInput() {
        guard let presenter = viewController?.presenter as? MenuPresenter else {
            XCTFail("Cannot assign viewController.presenter as MenuPreseter")
            return
        }
        
        XCTAssertNotNil(presenter.view, "view in Presenter is nil after configuration")
    }
    
    func testRouterInput() {
        guard let presenter = viewController?.presenter as? MenuPresenter else {
            XCTFail("Cannot assign viewController.presenter as MenuPreseter")
            return
        }
        
        guard let router = presenter.router as? MenuRouter else {
            XCTFail("Cannot assign presenter.router as MenuRouter")
            return
        }
        
        XCTAssertNotNil(router.view , "view in Router is nil after configuration")

        XCTAssertNotNil(presenter.router, "Router is nil after configuration")
        XCTAssertTrue(presenter.router is MenuRouter, "Router is not MenuRouter")
    }
    
    func testInteractorInput() {
        guard let presenter = viewController?.presenter as? MenuPresenter else {
            XCTFail("Cannot assign viewController.presenter as MenuPreseter")
            return
        }
        
        guard let interactor = presenter.interactor as? MenuInteractor else {
            XCTFail("Cannot assign presenter.interactor as MenuInteractor")
            return
        }
        
        XCTAssertNotNil(interactor.presenter , "presenter in interactor is nil after configuration")
        XCTAssertNotNil(presenter.interactor , "Interactor is nil after configuration")
        XCTAssertTrue(presenter.interactor is MenuInteractor, "Interactor is not MenuInteractor")
    }
}
