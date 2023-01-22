//
//  File.swift
//  DodoPetProject
//
//  Created by Назар Ткаченко on 19.12.2022.
//

@testable import SferaKit

struct Seeds {
    
    static var response = ProductsResponse(items: Products.all, categories: ["coffe","pizza"], banners: Banners.all)
    
    
    struct Products {
        static let all = [product1, product2, product3]
        
        static let product1 = Product(id: 0, name: "Латте", category: "коффе", itemDescription: "1/4 взбитой молочной пены, 2/4 горячего молока, 1/4 эспрессо", image: "latte", price: 150, count: 1)
        static let product2 = Product(id: 3, name: "Пицца Колбасный микс", category: "пицца", itemDescription: "Ветчина, шампиньоны, увеличенная порция моцареллы, томатный соус", image: "pizza1", price: 1200, count: 1)
        static let product3 = Product(id: 5, name: "Додстер Классик", category: "додстер", itemDescription: "Ветчина, шампиньоны, увеличенная порция моцареллы, томатный соус", image: "dodster1", price: 800, count: 1)
    }
    
    struct Banners {
        static let all = ["banner1","banner2", "banner3", "banner4", "banner5", "banner6"]
    }
}
