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
    
    @available(iOS 15.0, *)
    func fetchCollection() async throws -> ProductsResponse {
            guard let url = URL(string: "https://run.mocky.io/v3/bd429942-ecd4-4091-8fb4-c1b0952a4962")
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
