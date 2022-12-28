//
//  CartRouter.swift
//  test-sfera
//
//  Created by Назар Ткаченко on 27.11.2022.
//

import UIKit

protocol CartRouterInputProtocol {
    func showOrderProgress()
}

protocol CartRouterOutputProtocol {
}

final class CartRouter: CartRouterInputProtocol {
    
    weak var view: ScreenRoutable?
    
    func showOrderProgress() {
        
        let vc = OrderProgressVC()
        let nav = UINavigationController(rootViewController: vc)
        view?.push(nav, animated: true, completion: nil)
    }
}
