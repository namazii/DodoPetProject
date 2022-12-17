//
//  CartAssembly.swift
//  test-sfera
//
//  Created by Назар Ткаченко on 27.11.2022.
//

import Foundation

protocol CartAssemblyInputProtocol {
    func configure() -> CartViewController
}

final class CartAssembly: CartAssemblyInputProtocol {
    
    func configure() -> CartViewController {
        
        let tableAdapter = CartTableAdapter()
        
        let view = CartViewController.init(tableAdapter: tableAdapter)
        
//        tableAdapter.view = view
        
        let router = CartRouter()
        let presenter = CartPresenter.init(view: view, router: router)
        
        tableAdapter.presenter = presenter
        
        let interactor = CartInteractor(presenter: presenter)
        
        view.presenter = presenter
        presenter.interactor = interactor
        router.view = view
        
        return view
    }
}
