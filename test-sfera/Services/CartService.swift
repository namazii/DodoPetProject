//
//  CartService.swift
//  test-sfera
//
//  Created by Назар Ткаченко on 27.11.2022.
//

import Foundation

class CartService {
    static let shared = CartService()
    private init() {}
    
    private var productsArchiver = ProductsArchiver()
    
    private var products: [Product] = []
    
    var order: Order?
    
    func archiveProducts() {
        
        print(products)
        productsArchiver.save(products)
        
        print("Save Products OK")
    }
    
    func addProduct(model: Product) {
        print("addProduct")
        print(model)
        
        
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
            
            products[productIndex].items += 1
            print(products)
            
            //let productInCart = products[productIndex]
            return
        }
    }
    
    func updateProducts(model: [Product]) {
        var productArray: [Product] = []
        for i in model {
            if i.items != 0 {
                productArray.append(i)
            }
        }
        self.products = productArray
    }
    
    func deleteProduct(model: Product) {
        guard let index = products.firstIndex(where: {$0.id == model.id}) else { return }
        products.remove(at: index)
    }
    
    func getProducts() -> [Product] {
        print(products)
        return products
    }
    
    func loadProducts() {
        print(products)
        if products.isEmpty {
            let data = productsArchiver.retrieve()
            products.append(contentsOf: data)
        }
        print(products)
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
