//
//  ProductsAPI.swift
//  test-sfera
//
//  Created by Назар Ткаченко on 27.11.2022.
//

import Foundation

protocol ProductsAPIInputProtocol {
    func fetchCollection(completion: @escaping(ProductsResponse) -> Void)
}

final class ProductsAPI: ProductsAPIInputProtocol {
    
    func fetchCollection(completion: @escaping(ProductsResponse) -> Void) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "run.mocky.io"
        urlComponents.path = "/v3/31a65c6f-96d6-4938-8687-8b5fb38b75fd"
        
        guard let url = urlComponents.url else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let session = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let jsonData = data else { return }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let productsResponse = try jsonDecoder.decode(ProductsResponse.self, from: jsonData)
                
                DispatchQueue.main.async {
                    completion(productsResponse)
                }
            } catch {
                print(error)
            }
        }
        session.resume()
    }
}
