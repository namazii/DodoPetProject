//
//  CartInteractor.swift
//  test-sfera
//
//  Created by Назар Ткаченко on 27.11.2022.
//

import Foundation

protocol CartInteractorInputProtocol {
    init(presenter: CartInteractorOutputProtocol)
}

protocol CartInteractorOutputProtocol: AnyObject {
    
}

class CartInteractor: CartInteractorInputProtocol {
    unowned private let presenter: CartInteractorOutputProtocol
    
    required init(presenter: CartInteractorOutputProtocol) {
        self.presenter = presenter
    }
    
}
