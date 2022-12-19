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
    
    private var cartService = CartService()
    
    func loadCart() -> [Product] {
        let cartItems = cartService.getProducts()
        return cartItems
    }
    
    func updateCart(_ products: [Product]) {
        cartService.updateProducts(model: products)
    }
}
