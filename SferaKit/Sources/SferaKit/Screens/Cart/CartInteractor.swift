//
//  CartInteractor.swift
//  test-sfera
//
//  Created by Назар Ткаченко on 27.11.2022.
//

import Foundation

protocol CartInteractorInputProtocol {
}

protocol CartInteractorOutputProtocol: AnyObject {
}

final class CartInteractor: CartInteractorInputProtocol {
    
    weak var presenter: CartInteractorOutputProtocol?
    
    required init(presenter: CartInteractorOutputProtocol) {
        self.presenter = presenter
    }
}
