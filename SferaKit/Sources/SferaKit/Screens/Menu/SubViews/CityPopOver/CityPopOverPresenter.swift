//
//  CityPopOverPresenter.swift
//  test-sfera
//
//  Created by Назар Ткаченко on 27.11.2022.
//

import Foundation

final class CityPopOverPresenter: CityPopOverViewOutputProtocol {
    
    weak var view: CityPopOverViewInputProtocol?
    
    var router: CityPopOverRouterInputProtocol?
    var interactor: CityPopOverInteractorInputProtocol?
    
    init(view: CityPopOverViewInputProtocol, router: CityPopOverRouterInputProtocol) {
        self.view = view
        self.router = router
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
