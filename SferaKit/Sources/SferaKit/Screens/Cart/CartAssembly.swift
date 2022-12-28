//
//  CartAssembly.swift
//  test-sfera
//
//  Created by Назар Ткаченко on 27.11.2022.
//

protocol CartAssemblyInputProtocol {
    func configure() -> CartViewController
}

final class CartAssembly: CartAssemblyInputProtocol {
    
    func configure() -> CartViewController {
        
        let tableAdapter = CartTableAdapter()
        let view = CartViewController.init(tableAdapter: tableAdapter)
        let router = CartRouter()
        let presenter = CartPresenter.init(view: view, router: router)
        
        
        let interactor = CartInteractor(presenter: presenter)
        
        view.presenter = presenter
        tableAdapter.presenter = presenter
        presenter.interactor = interactor
        router.view = view
        
        return view
    }
}
