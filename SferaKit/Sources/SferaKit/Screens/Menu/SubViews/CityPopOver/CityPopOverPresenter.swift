//
//  CityPopOverPresenter.swift
//  test-sfera
//
//  Created by Назар Ткаченко on 27.11.2022.
//

import Foundation

final class CityPopOverPresenter: CityPopOverViewOutputProtocol {
    
    weak var view: CityPopOverViewInputProtocol?
    
//    var router:
    var interactor: CityPopOverInteractorInputProtocol?
    
    init(view: CityPopOverViewInputProtocol) {
        self.view = view
    }
    
    func loadView() {
        interactor?.fetchCities()
    }
}

extension CityPopOverPresenter: CityPopOverInteractorOutputProtocol {
    func receiveCitiesData(_ cities: [String]) {
        view?.updateCities(cities)
    }
}
