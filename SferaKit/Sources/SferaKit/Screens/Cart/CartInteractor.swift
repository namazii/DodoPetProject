//
//  CartInteractor.swift
//  test-sfera
//
//  Created by Назар Ткаченко on 27.11.2022.
//

import Foundation

protocol CartInteractorInputProtocol {
    func loadCart() -> [Product]
    func updateCart(_ products: [Product])
}

protocol CartInteractorOutputProtocol: AnyObject {
}

final class CartInteractor: CartInteractorInputProtocol {
    weak var presenter: CartInteractorOutputProtocol?
    
    required init(presenter: CartInteractorOutputProtocol) {
        self.presenter = presenter
    }
    
    func loadCart() -> [Product] {
        let cartItems = CartService.shared.getProducts()
        return cartItems
    }
    
    func updateCart(_ products: [Product]) {
        CartService.shared.updateProducts(model: products)
    }
}
