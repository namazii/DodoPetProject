//
//  MenuPresenter.swift
//  test-sfera
//
//  Created by Назар Ткаченко on 27.11.2022.
//

import Foundation

final class MenuPresenter: MenuViewOutputProtocol {
    
    weak var view: MenuViewInputProtocol?
    
    var router: MenuRouterInputProtocol?
    var interactor: MenuInteractorInputProtocol?
    
    var products: [Product] = []
    
    init(view: MenuViewInputProtocol, router: MenuRouterInputProtocol) {
        self.view = view
        self.router = router
    }
    
    func didTapCity() {
        print("tap")
    }
    
    func fetchCategories() {
        var category: Set<String> = []
        for product in products {
            category.insert(product.category)
        }
        
        let sortedCategories = [String](category).sorted(by: >)
        
        view?.updateCategories(sortedCategories)
    }
    
    func loadView() {
        interactor?.fetchProducts()
        interactor?.loadProducts()
    }

    
}

extension MenuPresenter: MenuInteractorOutputProtocol {    
    func receiveProducts(_ data: ProductsResponse) {
        
        let productsItems = data.items.sorted(by: { first, second in
            return first.category > second.category
        })
        
        products = productsItems
        view?.updateBanners(data.banners)
        view?.updateProducts(productsItems)
    }
}

extension MenuPresenter: MenuTableAdapterOutput {
    func itemSelected(index: Int) {
        
        let product = products[index]
        router?.showProductDetail(product: product)
        
    }
    
    
}
