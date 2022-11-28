//
//  ProductArchiver.swift
//  test-sfera
//
//  Created by Назар Ткаченко on 27.11.2022.
//

import Foundation

//Класс-сервис - бизнес-логика - архивируем массив участников
protocol OrderArchiverInput {
    func save(_ order: Order)
    func retrieve() -> Order?
}

final class OrderArchiver: OrderArchiverInput {
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    private let key = "Order"
    
    //MARK: - Public methods
    func save(_ order: Order) {
        
        //Array<Student> -> Data
        do {
            let data = try encoder.encode(order)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print(error)
        }
    }
    
    func retrieve() -> Order? {

        //Data -> Array<Student>
        guard let data = UserDefaults.standard.data(forKey: key) else { return nil }
        do {
            let array = try decoder.decode(Order.self, from: data)
            return array
        } catch {
            print(error)
        }
        return nil
    }
}
