//
//  CartService.swift
//  test-sfera
//
//  Created by Назар Ткаченко on 27.11.2022.
//

import Foundation

protocol CartServiceInputProtocol {
    func loadProducts() -> [Product]
    
    func addProduct(model: Product)
    func updateProducts(model: [Product])
    func deleteProduct(model: Product)
    
    
}

public class CartService: CartServiceInputProtocol {
    
    private var productRepository = ProductRepository()
    
    private var products: [Product] = []
    
    static let shared = CartService()
    
    var order: Order?
    
    private func saveProducts() {
        
        productRepository.save(products)
    }
    
    func addProduct(model: Product) {
        defer {
            print(#function)
            saveProducts()
        }
        
        if products.isEmpty {
            products.append(model)
            return
        }
        
        //Index - get element, write element
        let productIndex = products.firstIndex(where: { $0.id == model.id })
        
        if productIndex == nil {
            products.insert(model, at: 0)
            return
        }
        
        if let productIndex = productIndex {
            products[productIndex].count += 1
            return
        }
    }
    
    func updateProducts(model: [Product]) {
        defer { saveProducts() }
        
        var productArray: [Product] = []
        for i in model {
            if i.count != 0 {
                productArray.append(i)
            }
        }
        self.products = productArray
    }
    
    func deleteProduct(model: Product) {
        defer { saveProducts() }
        
        guard let index = products.firstIndex(where: {$0.id == model.id}) else { return }
        products.remove(at: index)
    }
    
    func loadProducts() -> [Product] {
        
        if products.isEmpty {
            let data = productRepository.retrieve()
            products.append(contentsOf: data)
        }
        
        return products
    }
    
    func createOrder() -> Order {
        var sum = 0
        for product in products {
            sum += product.price
        }
        let order = Order(products: products, totalSum: String(sum), deliveryMethod: "manual", time: "25 Sen 2017 21:11:55 GMT", name: "Антон", phone: "+7999999999", address: "Казань, Меридианная 4")
        
        return order
    }
}
