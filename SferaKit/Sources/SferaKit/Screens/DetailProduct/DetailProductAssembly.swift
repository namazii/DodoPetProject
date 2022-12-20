//
//  DetailProductAssembly.swift
//  test-sfera
//
//  Created by Назар Ткаченко on 27.11.2022.
//

import Foundation

protocol DetailProductAssemblyInputProtocol {
    func configure(with product: Product) -> DetailProductViewController
}

final class DetailProductAssembly: DetailProductAssemblyInputProtocol {
    
    func configure(with product: Product) -> DetailProductViewController {
        
        let tableAdapter = DetailProductTableAdapter()
        let view = DetailProductViewController.init(tableAdapter: tableAdapter)
        let router = DetailProductRouter()
        let presenter = DetailProductPresenter.init(view: view, router: router)
        let interactor = DetailProductInteractor.init(presenter: presenter)
        
        view.presenter = presenter
        presenter.interactor = interactor
        presenter.configureModule(with: product)
        router.view = view
        
        return view
    }
}
