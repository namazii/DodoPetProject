//
//  DetailProductInteractor.swift
//  DodoPetProject
//
//  Created by Назар Ткаченко on 27.11.2022.
//

protocol DetailProductInteractorInputProtocol {
    func addProductToCart(_ product: Product)
}

protocol DetailProductInteractorOutputProtocol: AnyObject {}

final class DetailProductInteractor: DetailProductInteractorInputProtocol {
    
    weak var presenter: DetailProductInteractorOutputProtocol?
    
    private var cartService: CartServiceInputProtocol
    
    required init(cartService: CartServiceInputProtocol = CartService.shared) {
        self.cartService = cartService
    }
    
    func addProductToCart(_ product: Product) {
        cartService.addProduct(model: product)
    }
}
