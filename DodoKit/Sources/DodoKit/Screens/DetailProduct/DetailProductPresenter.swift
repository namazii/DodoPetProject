//
//  DetailProductPresenter.swift
//  DodoPetProject
//
//  Created by Назар Ткаченко on 27.11.2022.
//

protocol DetailProductPresenterInputProtocol: AnyObject {
    func configureModule(with product: Product)
}

final class DetailProductPresenter: DetailProductViewOutputProtocol {
    
    weak var view: DetailProductViewInputProtocol?
    
    var router: DetailProductRouterInputProtocol?
    var interactor: DetailProductInteractorInputProtocol?
    
    var product: Product?
    
    init(interactor: DetailProductInteractorInputProtocol, router: DetailProductRouterInputProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    func addToCart() {
        guard let product = product else { return }
        interactor?.addProductToCart(product)
    }
}

extension DetailProductPresenter: DetailProductInteractorOutputProtocol {}

extension DetailProductPresenter: DetailProductPresenterInputProtocol {
    func configureModule(with product: Product) {
        self.product = product
        view?.updateProduct(product)
        view?.priceСalculation(product)
    }
}
