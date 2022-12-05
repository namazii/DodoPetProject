//
//  ProductArchiver.swift
//  test-sfera
//
//  Created by Назар Ткаченко on 27.11.2022.
//

import Foundation

//Класс-сервис - бизнес-логика - архивируем массив участников
protocol ProductsArchiverInput {
    func save(_ products: [Product])
    func retrieve() -> [Product]
}

final class ProductsArchiver: ProductsArchiverInput {
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    private let key = "Order"
    
    //MARK: - Public methods
    func save(_ products: [Product]) {
        
        //Array<Student> -> Data
        do {
            let data = try encoder.encode(products)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print(error)
        }
    }
    
    func retrieve() -> [Product] {

        //Data -> Array<Student>
        guard let data = UserDefaults.standard.data(forKey: key) else { return [] }
        do {
            let array = try decoder.decode([Product].self, from: data)
            return array
        } catch {
            print(error)
            return []
        }
    }
}
