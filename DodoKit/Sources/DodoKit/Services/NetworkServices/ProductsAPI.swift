//
//  ProductsAPI.swift
//  DodoPetProject
//
//  Created by Назар Ткаченко on 27.11.2022.
//

import Foundation

protocol ProductsAPIInputProtocol {
    func fetchCollection() async throws -> ProductsResponse
}

final class ProductsAPI: ProductsAPIInputProtocol {
    
    func fetchCollection() async throws -> ProductsResponse {
        do {
            let productsResponse = try await API.request(endpoint: ProductsEndpoint.fetchProducts, responseModel: ProductsResponse.self)
            return productsResponse
        } catch {
            throw error
        }
    }
}
