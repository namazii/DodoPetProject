//
//  CartPresenter.swift
//  test-sfera
//
//  Created by Назар Ткаченко on 27.11.2022.
//

import Foundation

class CartPresenter: CartViewOutputProtocol {
    unowned private let view: CartViewInputProtocol
    
    init(view: CartViewInputProtocol) {
        self.view = view
    }
    
    var interactor: CartInteractorInputProtocol?
    
    var products: [Product] = []
    
    //MARK: - Methods
//    func viewDisappear() {
//        interactor?.saveProducts()
//    }
    
    func didTapShowProductDetailCell() {
        //
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
