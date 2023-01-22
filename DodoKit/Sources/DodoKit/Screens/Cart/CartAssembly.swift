//
//  CartAssembly.swift
//  DodoPetProject
//
//  Created by Назар Ткаченко on 27.11.2022.
//

final class CartAssembly {
    
    func configure() -> CartViewController {
        
        let router = CartRouter()
        let tableAdapter = CartTableAdapter()
        
        let view = CartView(tableAdapter: tableAdapter)
        let interactor = CartInteractor()
        let presenter = CartPresenter(interactor: interactor, router: router)
        let controller = CartViewController(rootView: view, presenter: presenter)
        
        
        tableAdapter.controller = controller
        presenter.view = controller
        interactor.presenter = presenter
        router.view = controller
        
        return controller
    }
}
