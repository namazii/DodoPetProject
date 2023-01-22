//
//  DetailProductAssembly.swift
//  DodoPetProject
//
//  Created by Назар Ткаченко on 27.11.2022.
//

final class DetailProductAssembly{
    
    func configure(with product: Product) -> DetailProductViewController {
        
        let router = DetailProductRouter()
        let tableAdapter = DetailProductTableAdapter()
        
        let view = DetailProductView(tableAdapter: tableAdapter)
        let interactor = DetailProductInteractor()
        let presenter = DetailProductPresenter(interactor: interactor, router: router)
        let controller = DetailProductViewController(rootView: view, presenter: presenter)
        
        
        presenter.view = controller
        presenter.configureModule(with: product)
        interactor.presenter = presenter
        router.view = controller
        
        return controller
    }
}
