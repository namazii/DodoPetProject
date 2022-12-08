//
//  CityPopOverAssembly.swift
//  test-sfera
//
//  Created by Назар Ткаченко on 27.11.2022.
//

import Foundation

protocol CityPopOverAssemblyInputProtocol {
    func configure(withView view: CityPopOverViewController)
}

class CityPopOverAssembly: CityPopOverAssemblyInputProtocol {
    
    func configure() -> CityPopOverViewController {
        
        let view = CityPopOverViewController.init()
        
        let presenter = CityPopOverPresenter.init(view: view)
        
       
        
        let interactor = CityPopOverInteractor.init(presenter: presenter)
        
        view.presenter = presenter
        presenter.interactor = interactor
        
//        presenter.configureModule(with: product)
        
        return view
    }
    
    func configure(withView view: CityPopOverViewController) {
        let presenter = CityPopOverPresenter(view: view)
        let interactor = CityPopOverInteractor(presenter: presenter)
//        let router = MenuRouter()
        
        view.presenter = presenter
        presenter.interactor = interactor
//        presenter.router = router
//        router.view = view
    }
    
}
