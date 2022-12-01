//
//  CartPresenter.swift
//  test-sfera
//
//  Created by Назар Ткаченко on 27.11.2022.
//

import Foundation

class CartPresenter: CartViewOutputProtocol {
    
    func didTapShowProductDetailCell() {
        //
    }
    
    unowned private let view: CartViewInputProtocol
    
    var interactor: CartInteractorInputProtocol?
    
    var products: [Product] = [] 
    
    init(view: CartViewInputProtocol) {
        self.view = view
    }
    
    func updateProducts() {
        CartService.shared.updateProducts(model: products)
    }
    
    func getCart() {
        products = CartService.shared.getProducts()
    }
}

extension CartPresenter: CartInteractorOutputProtocol {
    
}
