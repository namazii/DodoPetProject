//
//  ProductsResponse.swift
//  test-sfera
//
//  Created by Назар Ткаченко on 27.11.2022.
//

// MARK: - ProductsResponse
struct ProductsResponse: Codable {
    let items: [Product]
    let categories, banners: [String]
}

// MARK: - Product
struct Product: Codable {
    let id: Int
    let name, category, itemDescription, image: String
    var price, count: Int
}
