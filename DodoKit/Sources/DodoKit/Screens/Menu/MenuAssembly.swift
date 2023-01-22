//
//  MenuAssembly.swift
//  DodoPetProject
//
//  Created by Назар Ткаченко on 27.11.2022.
//

final class MenuAssembly {
    
    func configure() -> MenuViewController {

        let router = MenuRouter()
        let productsAPI = ProductsAPI()
        let tableAdapter = MenuTableAdapter()
        
        
        let view = MenuView(tableAdapter: tableAdapter)
        let interactor = MenuInteractor(apiService: productsAPI)
        let presenter = MenuPresenter(interactor: interactor, router: router)
        let controller = MenuViewController(rootView: view, presenter: presenter)
        

        tableAdapter.controller = controller
        tableAdapter.view = controller
        presenter.view = controller
        interactor.presenter = presenter
        router.view = controller
        
        return controller
    }
}
