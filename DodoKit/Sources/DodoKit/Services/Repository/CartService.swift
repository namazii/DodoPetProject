//
//  CartService.swift
//  DodoPetProject
//
//  Created by Назар Ткаченко on 27.11.2022.
//

protocol CartServiceInputProtocol {
    func loadProducts() -> [Product]
    func addProduct(model: Product)
    func updateProducts(model: [Product])
    func deleteProduct(model: Product)
}

final class CartService: CartServiceInputProtocol {
    static let shared = CartService()
    
    private var productRepository = ProductRepository()
    
    private var products: [Product] = []
    
    private func saveProducts() {
        productRepository.save(products)
    }
    
    func addProduct(model: Product) {
        defer {
            saveProducts()
        }
        
        if products.isEmpty {
            products.append(model)
            return
        }
        
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
}
