//
//  DetailProductInteractor.swift
//  test-sfera
//
//  Created by Назар Ткаченко on 27.11.2022.
//

import Foundation

protocol DetailProductInteractorInputProtocol {
    func addProductToCart(_ product: Product)
}

protocol DetailProductInteractorOutputProtocol: AnyObject {
}

final class DetailProductInteractor: DetailProductInteractorInputProtocol {
    
    weak var presenter: DetailProductInteractorOutputProtocol?
    private var cartService: CartServiceInputProtocol

    required init(presenter: DetailProductInteractorOutputProtocol, cartService: CartServiceInputProtocol = CartService.shared) {
        self.presenter = presenter
        self.cartService = cartService
    }
    
    func addProductToCart(_ product: Product) {
        cartService.addProduct(model: product)
    }
}
