//
//  CityPopOverPresenter.swift
//  test-sfera
//
//  Created by Назар Ткаченко on 27.11.2022.
//

import Foundation

class CityPopOverPresenter: CityPopOverViewOutputProtocol {
    unowned private let view: CityPopOverViewInputProtocol
    
//    var router:
    var interactor: CityPopOverInteractorInputProtocol?
    
    var cities: [String] = []
    
    
    init(view: CityPopOverViewInputProtocol) {
        self.view = view
    }
    
    func loadView() {
        interactor?.fetchCities()
    }
}

extension CityPopOverPresenter: CityPopOverInteractorOutputProtocol {
    func receiveCitiesData(_ cities: [String]) {
        self.cities = cities
    }
}
