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
        let presenter = MenuPresenter(view: view)
        let interactor = MenuInteractor(presenter: presenter)
        let router = MenuRouter()
        
        view.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        router.view = view
    }
}
