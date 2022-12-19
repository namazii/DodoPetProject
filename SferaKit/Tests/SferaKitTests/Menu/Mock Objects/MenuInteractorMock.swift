//
//  MenuInteractorMock.swift
//  
//
//  Created by Назар Ткаченко on 16.12.2022.
//

@testable import SferaKit

class MenuInteractorMock: MenuInteractorInputProtocol {
    
    var isFetchProductsCalled = false
    func fetchProducts() {
        isFetchProductsCalled = true
    }
    
    var isloadProductsCalled = false
    func loadProducts() {
        isloadProductsCalled = true
    }
    
    
//    enum Call: Equatable {
//        case updateProducts(_ products: [Product])
//        case updateCategories(_ categories: [String])
//        case updateBanners(_ banners: [String])
//
//        static func == (lhs: Call, rhs: Call) -> Bool {
//            return String(describing: lhs) == String(describing: rhs)
//        }
//    }
//
//    private(set) var registeredCalls: [Call] = []
//
//    func updateProducts(_ products: [Product]) {
//        registeredCalls.append(.updateProducts(products))
//    }
//
//    func updateCategories(_ categories: [String]) {
//        registeredCalls.append(.updateCategories(categories))
//    }
//
//    func updateBanners(_ banners: [String]) {
//        registeredCalls.append(.updateBanners(banners))
//    }
}
