//
//  ProductsAPI.swift
//  test-sfera
//
//  Created by Назар Ткаченко on 27.11.2022.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}


class ProductsAPI {
    
    func fetchCollection() async throws -> ProductsResponse {
            guard let url = URL(string: "https://run.mocky.io/v3/f04ed268-416d-4cdf-812d-ab8a8a148d67")
            else {
                throw NetworkError.invalidURL
            }
            let (data,_) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            guard let response = try? decoder.decode(ProductsResponse.self, from: data) else {
                throw NetworkError.decodingError
            }
            return response
    }
}
