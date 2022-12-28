//
//  File.swift
//  
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
        
        //1 Конструктор URL
        var components = URLComponents()
        components.scheme = endpoint.sheme
        components.host = endpoint.baseURL
        components.path = endpoint.path
        
        components.queryItems = endpoint.parameters
        
        //2 Распаковали URL
        guard let url = components.url else {
            throw AppError.urlNotCreated
        }
        
        //3 HTTP - запрос
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method
        
        //5 Запуск запроса
        
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
