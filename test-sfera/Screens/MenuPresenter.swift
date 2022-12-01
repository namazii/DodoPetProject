//
//  MenuPresenter.swift
//  test-sfera
//
//  Created by Назар Ткаченко on 27.11.2022.
//

import Foundation

class MenuPresenter: MenuViewOutputProtocol {
    unowned private let view: MenuViewInputProtocol
    
    var router: MenuRouter
    var interactor: MenuInteractorInputProtocol?
    
    var products: [Product] = []
    
    init(view: MenuViewInputProtocol, router: MenuRouter) {
        self.view = view
        self.router = router
    }
    
    func didTapCity() {
        print("tap")
    }
    
    func fetchCategories() -> [String] {
        var category: Set<String> = []
        for product in products {
            category.insert(product.category)
        }
        
        let arr = [String](category).sorted(by: >)
        
        return arr
    }
    
    func loadView() {
        interactor?.fetchProducts()
    }
    
    func didTapShowProductDetailCell(_ product: Product) {
        router.showProductDetail(product: product)
    }
}

extension MenuPresenter: MenuInteractorOutputProtocol {
    
    func receiveProductsData(_ data: ProductsResponse) {
        let productsData = data.items.sorted(by: { first, second in
            return first.category > second.category
        })
        
        
        
        products = productsData
        view.updateProducts(data.banners)
    }
}
