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
    
    required init(view: CartViewInputProtocol) {
        self.view = view
    }
    
    func getCart() {
        products = CartService.shared.getProducts()
    }
}

extension CartPresenter: CartInteractorOutputProtocol {
    
}
