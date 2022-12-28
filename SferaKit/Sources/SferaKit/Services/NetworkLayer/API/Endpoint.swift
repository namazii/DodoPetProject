//
//  File.swift
//  
//
//  Created by Назар Ткаченко on 27.12.2022.
//

import Foundation

//Протокол - через который конструируем URL (интерфейс конструктора URL)
protocol Endpoint {
    
    //https
    var sheme: String { get }
    
    //"api"
    var baseURL: String { get }
    
    //"//"
    var path: String { get }
    
    var parameters: [URLQueryItem] { get }
    
    var method: String { get }
}
