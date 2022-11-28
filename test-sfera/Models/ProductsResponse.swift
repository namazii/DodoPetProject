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
    var cinnamon, sugar: Bool
    var variant, size: String
    var price, items: Int

    enum CodingKeys: String, CodingKey {
        case id, name, category
        case itemDescription = "description"
        case image, cinnamon, sugar, variant, size, price, items
    }
}
