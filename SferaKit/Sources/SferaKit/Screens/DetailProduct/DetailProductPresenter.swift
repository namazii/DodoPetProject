//
//  DetailProductPresenter.swift
//  test-sfera
//
//  Created by Назар Ткаченко on 27.11.2022.
//

import Foundation

protocol DetailModuleInputProtocol: AnyObject {
    func configureModule(with product: Product)
}

final class DetailProductPresenter: DetailProductViewOutputProtocol {
    
    weak var view: DetailProductViewInputProtocol?
    
//    var router: MenuRouter?
    var interactor: DetailProductInteractorInputProtocol?
    
    var product: Product?
    
    init(view: DetailProductViewInputProtocol) {
        self.view = view
    }
    
    func addToCart() {
        guard let product = product else { return }
        CartService.shared.addProduct(model: product)
    }
    
    func loadView() {
        interactor?.fetchProduct()
    }
}

extension DetailProductPresenter: DetailProductInteractorOutputProtocol {
    func receiveProductsData(_ data: Product?) {
        self.product = data
    }
}

extension DetailProductPresenter: DetailModuleInputProtocol {
    func configureModule(with product: Product) {
//        self.product = product
        view?.updateProduct(product)    }
}
