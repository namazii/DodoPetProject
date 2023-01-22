//
//  CartTableAdapter.swift
//  DodoPetProject
//
//  Created by Назар Ткаченко on 17.12.2022.
//

import UIKit

protocol CartTableAdapterOutputProtocol: AnyObject {
    func tableReloadData()
    func sendProducts(_ products: [Product])
}

final class CartTableAdapter: NSObject {
    weak var controller: CartTableAdapterOutputProtocol?
    var products: [Product] = []
}

//MARK: - UITableViewDelegate
extension CartTableAdapter: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CartCell.reuseID, for: indexPath) as? CartCell else { return UITableViewCell() }
        
        cell.selectionStyle = .none
        cell.delegate = self
        cell.configure(model: products[indexPath.row])
        
        return cell
    }
}

//MARK: - CartCellDelegate
extension CartTableAdapter: CartCellDelegate {
    /**
     from CartCell cartStepperView method comes stepper counter and product
     and in the normal method we delegate the steper counter in the presenter
     */
    func cartCell(counter: Int, product: Product) {
        guard let productIndex = products.firstIndex(where: {$0.id == product.id }) else { return }
        
        products[productIndex].count = counter
        
        if counter == 0 {
            products.remove(at: productIndex)
            controller?.tableReloadData()
        }
        controller?.sendProducts(products)
    }
}
