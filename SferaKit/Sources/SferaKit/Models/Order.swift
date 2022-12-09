//
//  Order.swift
//  test-sfera
//
//  Created by Назар Ткаченко on 27.11.2022.
//

import Foundation

// MARK: - OrderProducts
class Order: Codable {
    let products: [Product]
    let totalSum, deliveryMethod, time, name: String
    let phone, address: String

    init(products: [Product], totalSum: String, deliveryMethod: String, time: String, name: String, phone: String, address: String) {
        self.products = products
        self.totalSum = totalSum
        self.deliveryMethod = deliveryMethod
        self.time = time
        self.name = name
        self.phone = phone
        self.address = address
    }
    
    enum CodingKeys: String, CodingKey {
        case products
        case totalSum = "total_sum"
        case deliveryMethod = "delivery_method"
        case time, name, phone, address
    }
}

//// MARK: - Product
//struct Order: Codable {
//    let id: Int
//    let name, category, productDescription, image: String
//    let cinnamon, sugar: Bool
//    let variant, size: String
//    let price, count: Int
//
//    enum CodingKeys: String, CodingKey {
//        case id, name, category
//        case productDescription = "description"
//        case image, cinnamon, sugar, variant, size, price, count
//    }
//}
