//
//  DetailProductInteractor.swift
//  test-sfera
//
//  Created by Назар Ткаченко on 27.11.2022.
//

import Foundation

protocol DetailProductInteractorInputProtocol {
    func fetchProduct()
}

protocol DetailProductInteractorOutputProtocol: AnyObject {
    func receiveProductsData(_ data: Product?)
}

final class DetailProductInteractor: DetailProductInteractorInputProtocol {
    func fetchProduct() {
    }
    
    weak var presenter: DetailProductInteractorOutputProtocol?

    required init(presenter: DetailProductInteractorOutputProtocol) {
        self.presenter = presenter
    }
}
