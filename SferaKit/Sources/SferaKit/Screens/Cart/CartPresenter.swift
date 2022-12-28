//
//  CartPresenter.swift
//  test-sfera
//
//  Created by Назар Ткаченко on 27.11.2022.
//

final class CartPresenter: CartViewOutputProtocol {
    
    weak var view: CartViewInputProtocol?
    
    var router: CartRouterInputProtocol?
    var interactor: CartInteractorInputProtocol?
    
    init(view: CartViewInputProtocol, router: CartRouterInputProtocol) {
        self.view = view
        self.router = router
    }
    
    private func totalSum(_ products: [Product]) -> String {
        var totalPrice = 0
        products.forEach { product in
            totalPrice += (product.price * product.count)
        }
        return String(totalPrice)
    }
    
    //MARK: - Methods    
    func didTapOrderButton() {
        router?.showOrderProgress()
        interactor?.updateCart([])
    }
    
    func getCart() {
        guard let cartItems = interactor?.loadCart() else { return }
        
        view?.updateProducts(cartItems)
        
        let price = totalSum(cartItems)
        view?.getTotalPrice(price: price)
    }
}

extension CartPresenter: CartInteractorOutputProtocol {
}

extension CartPresenter: CartTableAdapterOutputProtocol {
    func tableReloadData() {
        view?.tableReloadData()
    }
    
    func sendProducts(_ products: [Product]) {
        interactor?.updateCart(products)
        let price = totalSum(products)
        view?.getTotalPrice(price: price)
    }
}
