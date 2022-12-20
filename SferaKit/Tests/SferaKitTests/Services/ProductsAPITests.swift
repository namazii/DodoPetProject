//
//  ProductsAPITests.swift
//  
//
//  Created by Назар Ткаченко on 20.12.2022.
//

import XCTest
@testable import SferaKit

final class ProductsAPITests: XCTestCase {
    
    class ProductsAPISpy: ProductsAPIInputProtocol {
        
        var fetchCollectionCalled = false
        var productsItems: [Product]?
        
        func fetchCollection(completion: @escaping (ProductsResponse) -> Void) {
            fetchCollectionCalled = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                
                completion(Seeds.response)
            }
        }
    }
    
    func testFetchCollectionShouldReturnProductsResponse() {
        let expectation = XCTestExpectation(description: #function)
        
        let productAPISpy = ProductsAPISpy()
        productAPISpy.fetchCollection { items in
            expectation.fulfill()
            productAPISpy.productsItems = items.items
        }
        
        wait(for: [expectation], timeout: 3.0)
        
        XCTAssert(productAPISpy.fetchCollectionCalled, "Calling fetchCollection() should ask the response for ProductsResponse")
        XCTAssert(productAPISpy.productsItems?.count ?? 0 > 0, "productsItems is empty")
    }
    
}
