//
//  CartAssembly.swift
//  test-sfera
//
//  Created by Назар Ткаченко on 27.11.2022.
//

import Foundation

protocol CartAssemblyInputProtocol {
    func configure(withView view: CartViewController)
}

class CartAssembly: CartAssemblyInputProtocol {
    
    func configure(withView view: CartViewController) {
        let presenter = CartPresenter(view: view)
        let interactor = CartInteractor(presenter: presenter)
        
        view.presenter = presenter
        presenter.interactor = interactor
    }
}
