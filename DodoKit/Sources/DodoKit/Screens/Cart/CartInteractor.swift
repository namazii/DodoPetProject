//
//  CartInteractor.swift
//  DodoPetProject
//
//  Created by Назар Ткаченко on 27.11.2022.
//

protocol CartInteractorInputProtocol {
    func loadCart() -> [Product]
    func updateCart(_ products: [Product])
}

protocol CartInteractorOutputProtocol: AnyObject {}

final class CartInteractor: CartInteractorInputProtocol {
    weak var presenter: CartInteractorOutputProtocol?
    
    private var cartService: CartServiceInputProtocol
    
    required init(cartService: CartServiceInputProtocol = CartService.shared) {
        self.cartService = cartService
    }
    
    func loadCart() -> [Product] {
        let cartItems = cartService.loadProducts()
        return cartItems
    }
    
    func updateCart(_ products: [Product]) {
        cartService.updateProducts(model: products)
    }
}
