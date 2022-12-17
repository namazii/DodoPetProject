//
//  MenuInteractor.swift
//  test-sfera
//
//  Created by Назар Ткаченко on 27.11.2022.
//

import Foundation

protocol MenuInteractorInputProtocol {
    func fetchProducts()
    func loadProducts()
}

protocol MenuInteractorOutputProtocol: AnyObject {
    func receiveProducts(_ data: ProductsResponse)
}

final class MenuInteractor: MenuInteractorInputProtocol {
    
    weak var presenter: MenuInteractorOutputProtocol?
    
    required init(presenter: MenuInteractorOutputProtocol) {
        self.presenter = presenter
    }
    
    private let productsAPI = ProductsAPI()
    
    func loadProducts() {
        CartService.shared.loadProducts()
    }
    
    //MARK: - Requests
    func fetchProducts() {
        productsAPI.fetchCollection() { [weak self] result in
            self?.presenter?.receiveProducts(result)
        }
    }
}
