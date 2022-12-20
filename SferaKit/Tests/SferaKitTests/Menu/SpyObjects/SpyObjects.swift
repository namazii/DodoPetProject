//
//  File.swift
//  
//
//  Created by Назар Ткаченко on 19.12.2022.
//

@testable import SferaKit
import UIKit

//MARK: - MenuPresenterSpy
class MenuPresenterSpy: MenuInteractorOutputProtocol, MenuViewOutputProtocol, MenuTableAdapterOutputProtocol {
    var itemSelectedItems: Int?
    var itemSelectedCalled = false
    func itemSelected(index: Int) {
        itemSelectedCalled = true
        itemSelectedItems = index
    }
    
    var fetchedProductsCalled = false
    func fetchedProducts(_ data: ProductsResponse) {
        fetchedProductsCalled = true
    }
    
    var fetchProductsCalled = false
    func fetchProducts() {
        fetchProductsCalled = true
    }
    
    var cityButtonTappedCalled = false
    func cityButtonTapped() {
        cityButtonTappedCalled = true
    }
    
    var fetchCategoriesCalled = false
    func fetchCategories() {
        fetchCategoriesCalled = true
    }
    
    var products: [Product] = []
}

//MARK: - ProductsAPISpy
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
}

//MARK: - CartServiceSpy
class CartServiceSpy: CartServiceInputProtocol {
    var loadProductsCalled = false
    func loadProducts() -> [Product] {
        loadProductsCalled = true
        return Seeds.response.items
    }
    
    var addProductItems: Product?
    var addProductCalled = false
    func addProduct(model: Product) {
        addProductCalled = true
        addProductItems = model
    }
    
    var updateProductsItems: [Product]?
    var updateProductsCalled = false
    func updateProducts(model: [Product]) {
        updateProductsCalled = true
        if model.count != 0 {
            updateProductsItems = model
        }
    }
    
    var deleteProductItems: Product?
    var deleteProductCalled = false
    func deleteProduct(model: Product) {
        deleteProductCalled = true
        deleteProductItems = model
    }
}

//MARK: - MenuViewSpy
class MenuViewSpy: MenuViewInputProtocol {
    var updateBannersCalled = false
    func updateBanners(_ banners: [String]) {
        updateBannersCalled = true
    }
    
    var updateProductsCalled = false
    func updateProducts(_ products: [SferaKit.Product]) {
        updateProductsCalled = true
    }
    
    var updateCategoriesCalled = false
    var updateCategoriesItems: [String]?
    func updateCategories(_ categories: [String]) {
        updateCategoriesCalled = true
        if categories.count != 0 {
            updateCategoriesItems = categories
        }
    }
}

//MARK: - MenuRouterSpy
class MenuRouterSpy: MenuRouterInputProtocol {
    var showProductDetailCalled = false
    func showProductDetail(product: SferaKit.Product) {
        showProductDetailCalled = true
    }
}

//MARK: - MenuInteractorSpy
class MenuInteractorSpy: MenuInteractorInputProtocol {
    var fetchProductsCalled = false
    func fetchProducts() {
        fetchProductsCalled = true
    }
    
    var loadProductsCalled = false
    func loadProducts() {
        loadProductsCalled = true
    }
}

//MARK: - TableAdapter
class TableViewSpy: UITableView {
    var reloadDataCalled = false
    override func reloadData() {
        reloadDataCalled = true
    }
}
