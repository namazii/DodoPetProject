//
//  CartPresenter.swift
//  test-sfera
//
//  Created by Назар Ткаченко on 27.11.2022.
//

import Foundation

final class CartPresenter: CartViewOutputProtocol {
    
    weak var view: CartViewInputProtocol?
    
    var router: CartRouterInputProtocol?
    var interactor: CartInteractorInputProtocol?
    
    init(view: CartViewInputProtocol, router: CartRouterInputProtocol) {
        self.view = view
        self.router = router
    }

    var products: [Product] = []
    
    private func totalSum() -> String {
        var totalPrice = 0
        products.forEach { product in
            totalPrice += (product.price * product.count)
        }
        return String(totalPrice)
    }
    
    //MARK: - Methods    
    func didTapOrderButton() {
        router?.showOrderProgress()
    }
    
    func getCart() {
        products = CartService.shared.getProducts()
        let price = totalSum()
        view?.getTotalPrice(price: price)
    }
}

extension CartPresenter: CartInteractorOutputProtocol {
}

extension CartPresenter: CartTableAdapterOutput {
    func updateProducts() -> [Product] {
        return products
    }
    
    func requestPrice() {
        let price = totalSum()
        view?.getTotalPrice(price: price)
        CartService.shared.updateProducts(model: products)
    }
}
