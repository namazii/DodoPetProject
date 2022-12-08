//
//  MenuAssembly.swift
//  test-sfera
//
//  Created by Назар Ткаченко on 27.11.2022.
//

import Foundation

protocol MenuAssemblyInputProtocol {
    func configure(withView view: MenuViewController)
}


class MenuAssembly: MenuAssemblyInputProtocol {
    
    func configure(withView view: MenuViewController) {
        
        let router = MenuRouter()
        
        let presenter = MenuPresenter.init(view: view, router: router)
        let interactor = MenuInteractor(presenter: presenter)
        
        view.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        router.view = view
    }
}
