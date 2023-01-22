//
//  File.swift
//  DodoPetProject
//
//  Created by Назар Ткаченко on 27.12.2022.
//

import Foundation

enum ProductsEndpoint: Endpoint {
    
    case fetchProducts
    
    var sheme: String {
        switch self {
        default:
            return "https"
        }
    }

    var baseURL: String {
        switch self {
        default:
            return "run.mocky.io"
        }
    }
    
    var path: String {
        switch self {
        case .fetchProducts:
            return "/v3/b2ffc7bc-18d6-4525-8a38-34257f88e871"
        }
    }
    
    var parameters: [URLQueryItem] { return []}
    
    var method: String {
        switch self {
        case.fetchProducts:
            return "GET"
        }
    }
}
