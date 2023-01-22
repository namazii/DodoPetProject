//
//  MenuPresenter.swift
//  DodoPetProject
//
//  Created by Назар Ткаченко on 27.11.2022.
//

import Foundation

final class MenuPresenter: MenuViewOutputProtocol {
    
    weak var view: MenuViewInputProtocol?
    
    var router: MenuRouterInputProtocol?
    var interactor: MenuInteractorInputProtocol?
    
    var products: [Product] = []
    
    init(interactor: MenuInteractorInputProtocol, router: MenuRouterInputProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    func fetchCategories() {
        var category: Set<String> = []
        for product in products {
            category.insert(product.category)
        }
        
        let sortedCategories = [String](category).sorted(by: >)
        
        view?.updateCategories(sortedCategories)
    }
    
    func fetchProducts() {
        interactor?.fetchProducts()
        interactor?.loadProducts()
    }
    
    func itemSelected(index: Int) {
        let product = products[index]
        router?.showProductDetail(product: product)
    }
}

extension MenuPresenter: MenuInteractorOutputProtocol {
    
    func fetchedProducts(_ data: ProductsResponse) {
        
        DispatchQueue.main.async { [weak self] in
            
            let productsItems = data.items.sorted(by: { first, second in
                return first.category > second.category
            })
            
            self?.products = productsItems
            self?.view?.updateBanners(data.banners)
            self?.view?.updateProducts(productsItems)
        }
    }
}
