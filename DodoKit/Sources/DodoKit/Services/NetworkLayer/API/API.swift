//
//  File.swift
//  DodoPetProject
//
//  Created by Назар Ткаченко on 27.12.2022.
//

import Foundation

enum AppError: Error {
    case urlNotCreated
    
    var description: String {
        switch self {
        case .urlNotCreated:
            return "Error: URL not created"
        }
    }
}

class API {
    
    class func request<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) async throws -> T {
        
        var components = URLComponents()
        components.scheme = endpoint.sheme
        components.host = endpoint.baseURL
        components.path = endpoint.path
        
        components.queryItems = endpoint.parameters
        
        guard let url = components.url else {
            throw AppError.urlNotCreated
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method
        
        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            let response = try JSONDecoder().decode(responseModel, from: data)
            
            return response
        } catch {
            print(error)
            throw error 
        }
    }
}
