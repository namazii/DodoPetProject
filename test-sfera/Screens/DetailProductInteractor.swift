//
//  DetailProductInteractor.swift
//  test-sfera
//
//  Created by Назар Ткаченко on 27.11.2022.
//

import Foundation

protocol DetailProductInteractorInputProtocol {
    init(presenter: DetailProductInteractorOutputProtocol)
    func fetchProduct()
}

protocol DetailProductInteractorOutputProtocol: AnyObject {
    func receiveProductsData(_ data: Product?)
}

class DetailProductInteractor: DetailProductInteractorInputProtocol {
    func fetchProduct() {
        
    }
    
    unowned private let presenter: DetailProductInteractorOutputProtocol

    required init(presenter: DetailProductInteractorOutputProtocol) {
        self.presenter = presenter
    }
}
