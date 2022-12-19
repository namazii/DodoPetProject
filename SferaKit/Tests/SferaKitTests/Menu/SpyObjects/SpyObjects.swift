//
//  File.swift
//  
//
//  Created by Назар Ткаченко on 19.12.2022.
//

@testable import SferaKit

class PresenterSpy: MenuInteractorOutputProtocol {
    var fetchedProductsCalled = false
    func fetchedProducts(_ data: ProductsResponse) {
        fetchedProductsCalled = true
    }
    
    var fetchProductsCalled = false
    func fetchProducts() {
        fetchProductsCalled = true
    }
    
    //cityButtonTapped
    //searchTextChanged
    //productStepperChanged
    //
    var cityButtonTappedCalled = false
    func cityButtonTapped() {
        cityButtonTappedCalled = true
    }
    
    var fetchCategoriesCalled = false
    func fetchCategories() {
        fetchCategoriesCalled = true
    }
    
    var products: [Product] = []
    
//    var presentMoviesCalled = false
//    var movies: [Movie]?
//    func presentFetchedMovies(_ movies: [Movie]) {
//        presentMoviesCalled = true
//        self.movies = movies
//    }
}

class ProductsAPISpy: ProductsAPIInputProtocol {
    var response: ProductsResponse
    
    init(response: ProductsResponse) {
        self.response = response
    }
    
    var fetchCollectionCalled = false
    func fetchCollection(completion: @escaping (ProductsResponse) -> Void) {
        fetchCollectionCalled = true
        completion(response)
    }
//    var fetchMoviesCalled = false
//    var movies: [Movie]
//    init(movies: [Movie] = []) {
//        self.movies = movies
//    }
//    override func fetchMovies(completionHandler: @escaping
//     ([Movie]) -> Void) {
//        fetchMoviesCalled = true
//        completionHandler(movies)
//    }
}

class CartServiceSpy: CartServiceInputProtocol {
    var loadProductsCalled = false
    func loadProducts() {
        loadProductsCalled = true
    }
}

class ViewSpy: MenuViewInputProtocol {
    var updateBannersCalled = false
    func updateBanners(_ banners: [String]) {
        updateBannersCalled = true
    }
    
    var updateProductsCalled = false
    func updateProducts(_ products: [SferaKit.Product]) {
        updateProductsCalled = true
    }
    
    var updateCategoriesCalled = false
    func updateCategories(_ categories: [String]) {
        updateCategoriesCalled = true
    }
}

class RouterSpy: MenuRouterInputProtocol {
    var showProductDetailCalled = false
    func showProductDetail(product: SferaKit.Product) {
        showProductDetailCalled = true
    }
}

