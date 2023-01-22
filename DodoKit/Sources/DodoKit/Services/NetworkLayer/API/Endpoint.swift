//
//  File.swift
//  DodoPetProject
//
//  Created by Назар Ткаченко on 27.12.2022.
//

import Foundation

protocol Endpoint {
    
    var sheme: String { get }
    
    var baseURL: String { get }
    
    var path: String { get }
    
    var parameters: [URLQueryItem] { get }
    
    var method: String { get }
}
