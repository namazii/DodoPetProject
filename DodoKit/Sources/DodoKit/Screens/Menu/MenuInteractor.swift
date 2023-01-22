//
//  MenuInteractor.swift
//  DodoPetProject
//
//  Created by Назар Ткаченко on 27.11.2022.
//

protocol MenuInteractorInputProtocol {
    func fetchProducts()
    func loadProducts()
}

protocol MenuInteractorOutputProtocol: AnyObject {
    func fetchedProducts(_ data: ProductsResponse)
}

final class MenuInteractor: MenuInteractorInputProtocol {
    
    weak var presenter: MenuInteractorOutputProtocol?
    
    var productsAPI: ProductsAPIInputProtocol?
    private var cartService: CartServiceInputProtocol
    
    required init(apiService: ProductsAPIInputProtocol, cartService: CartServiceInputProtocol = CartService.shared) {
        self.productsAPI = apiService
        self.cartService = cartService
    }
    
    func loadProducts() {
       let _ = cartService.loadProducts()
    }
    
    //MARK: - Requests
    func fetchProducts() {
        Task {
            do {
                guard let response = try await productsAPI?.fetchCollection() else { return }
                presenter?.fetchedProducts(response)
            } catch {
                print(error)
            }
        }
    }
}
