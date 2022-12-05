//
//  MenuInteractor.swift
//  test-sfera
//
//  Created by Назар Ткаченко on 27.11.2022.
//

import Foundation

protocol MenuInteractorInputProtocol {
    init(presenter: MenuInteractorOutputProtocol)
    func fetchProducts()
    func loadProducts()
}

protocol MenuInteractorOutputProtocol: AnyObject {
    func receiveProductsData(_ data: ProductsResponse)
}

class MenuInteractor: MenuInteractorInputProtocol {
    unowned private let presenter: MenuInteractorOutputProtocol
    
    required init(presenter: MenuInteractorOutputProtocol) {
        self.presenter = presenter
    }
    
    private let productsAPI = ProductsAPI()
    
    func loadProducts() {
        CartService.shared.loadProducts()
    }
    
    //MARK: - Requests
    func fetchProducts() {
        Task {
            do {
                let result = try await productsAPI.fetchCollection() //Запрос в сеть
                
                presenter.receiveProductsData(result)
                
            } catch {
                print(error)
            }
        }
    }
}
