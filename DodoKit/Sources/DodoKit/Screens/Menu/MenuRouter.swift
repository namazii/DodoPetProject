//
//  MenuRouter.swift
//  DodoPetProject
//
//  Created by Назар Ткаченко on 27.11.2022.
//

import UIKit

protocol MenuRouterInputProtocol {
    func showProductDetail(product: Product)
}

protocol MenuRouterOutputProtocol {}

final class MenuRouter: MenuRouterInputProtocol {
    
    weak var view: ScreenRoutable?
    
    func showProductDetail(product: Product) {
        
        let vc = DetailProductAssembly().configure(with: product)
        
        view?.presentScreen(vc, animated: true, completion: nil)
    }
}
