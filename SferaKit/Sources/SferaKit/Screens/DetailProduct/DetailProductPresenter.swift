//
//  DetailProductPresenter.swift
//  test-sfera
//
//  Created by Назар Ткаченко on 27.11.2022.
//

protocol DetailModuleInputProtocol: AnyObject {
    func configureModule(with product: Product)
}

final class DetailProductPresenter: DetailProductViewOutputProtocol {
    
    weak var view: DetailProductViewInputProtocol?
    
    var router: DetailProductRouterInputProtocol?
    var interactor: DetailProductInteractorInputProtocol?
    
    var product: Product?
    
    init(view: DetailProductViewInputProtocol, router: DetailProductRouterInputProtocol) {
        self.view = view
        self.router = router
    }
    
    func addToCart() {
        guard let product = product else { return }
        interactor?.addProductToCart(product)
    }
}

extension DetailProductPresenter: DetailProductInteractorOutputProtocol {
}

extension DetailProductPresenter: DetailModuleInputProtocol {
    func configureModule(with product: Product) {
        self.product = product
        view?.updateProduct(product)
        view?.priceСalculation(product)
    }
}
