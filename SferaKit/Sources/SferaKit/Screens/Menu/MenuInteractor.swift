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
                if #available(iOS 15.0, *) {
                    let result = try await productsAPI.fetchCollection()
                    presenter.receiveProductsData(result)
                } else {
                    // Fallback on earlier versions
                } //Запрос в сеть
                
            } catch {
                print(error)
            }
        }
    }
}
