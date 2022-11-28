//
//  CityPopOverInteractorInputProtocol.swift
//  test-sfera
//
//  Created by Назар Ткаченко on 27.11.2022.
//

import Foundation

protocol CityPopOverInteractorInputProtocol {
    init(presenter: CityPopOverInteractorOutputProtocol)
    func fetchCities()
}

protocol CityPopOverInteractorOutputProtocol: AnyObject {
    func receiveCitiesData(_ citys: [String])
}

class CityPopOverInteractor: CityPopOverInteractorInputProtocol {
    unowned private let presenter: CityPopOverInteractorOutputProtocol

    required init(presenter: CityPopOverInteractorOutputProtocol) {
        self.presenter = presenter
    }
    
    func fetchCities() {
        presenter.receiveCitiesData(["Москва", "Санкт-Петербург", "Новосибирск", "Екатеринбург", "Казань", "Самара", "Омск"])
    }
}
