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

    required init(presenter: DetailProductInteractorOutputProtocol) {
        self.presenter = presenter
    }
    
    private var cartService = CartService()
    
    func addProductToCart(_ product: Product) {
        cartService.addProduct(model: product)
    }
}
