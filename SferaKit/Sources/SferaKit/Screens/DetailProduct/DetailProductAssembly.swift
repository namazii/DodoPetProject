//
//  DetailProductAssembly.swift
//  test-sfera
//
//  Created by Назар Ткаченко on 27.11.2022.
//

import Foundation

protocol DetailProductAssemblyInputProtocol {
    func configure(withView view: DetailProductViewController)
    func configure(with product: Product) -> DetailProductViewController
}

class DetailProductAssembly: DetailProductAssemblyInputProtocol {
    
    func configure(with product: Product) -> DetailProductViewController {
        
        let view = DetailProductViewController.init()
        
        let presenter = DetailProductPresenter.init(view: view)
        
       
        
        let interactor = DetailProductInteractor.init(presenter: presenter)
        
        view.presenter = presenter
        presenter.interactor = interactor
        
        presenter.configureModule(with: product)
        
        return view
    }
    
    func configure(withView view: DetailProductViewController) {
        let presenter = DetailProductPresenter(view: view)
        let interactor = DetailProductInteractor(presenter: presenter)
//        let router = MenuRouter()

        view.presenter = presenter
        presenter.interactor = interactor
//        presenter.router = router
//        router.view = view

    }
}
