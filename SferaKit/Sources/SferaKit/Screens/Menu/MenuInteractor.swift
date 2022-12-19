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
    func fetchedProducts(_ data: ProductsResponse)
}

final class MenuInteractor: MenuInteractorInputProtocol {
    
    weak var presenter: MenuInteractorOutputProtocol?
    
    var productsAPI: ProductsAPIInputProtocol?
    var repository: ProductRepository?
    var cartService: CartServiceInputProtocol?
    
    required init(presenter: MenuInteractorOutputProtocol, apiService: ProductsAPIInputProtocol, cartService: CartServiceInputProtocol) {
        self.presenter = presenter
        self.productsAPI = apiService
        self.cartService = cartService
    }
    
    func loadProducts() {
        cartService?.loadProducts()
    }
    
    //MARK: - Requests
    func fetchProducts() {
        productsAPI?.fetchCollection() { [weak self] result in
            self?.presenter?.fetchedProducts(result)
        }
    }
}
