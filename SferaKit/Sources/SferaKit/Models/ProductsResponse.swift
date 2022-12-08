//
//  ProductsResponse.swift
//  test-sfera
//
//  Created by Назар Ткаченко on 27.11.2022.
//

import Foundation

// MARK: - ProductsResponse
struct ProductsResponse: Codable {
    let items: [Product]
    let categories, banners: [String]
}


// MARK: - Product
struct Product: Codable {
    let id: Int
    let name, category, itemDescription, image: String
//    var cinnamon, sugar: Bool
//    var variant, size: String
    var price, count: Int

//    public init(id: Int, name: String, category: String, itemDescription: String, image: String, price: Int, count: Int) {
//        self.id = id
//        self.name = name
//        self.category = category
//        self.itemDescription = itemDescription
//        self.image = image
//        self.price = price
//        self.count = count
//    }
    
    enum CodingKeys: String, CodingKey {
        case id, name, category
        case itemDescription = "description"
        case image, price, count
    }
}
