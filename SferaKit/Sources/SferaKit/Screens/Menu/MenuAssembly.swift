//
//  MenuAssembly.swift
//  test-sfera
//
//  Created by Назар Ткаченко on 27.11.2022.
//

import Foundation

protocol MenuAssemblyInputProtocol {
    func configure() -> MenuViewController
}


final class MenuAssembly: MenuAssemblyInputProtocol {
    
    func configure() -> MenuViewController {
        
        let tableAdapter = MenuTableAdapter()
        
        let view = MenuViewController.init(tableAdapter: tableAdapter)
        
        tableAdapter.view = view
        
        let router = MenuRouter()
        let presenter = MenuPresenter.init(view: view, router: router)
        
        tableAdapter.presenter = presenter
        
        let interactor = MenuInteractor(presenter: presenter)
        
        view.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        router.view = view
        
        return view
    }
}
