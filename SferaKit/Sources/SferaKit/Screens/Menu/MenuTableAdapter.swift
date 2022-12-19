//
//  File.swift
//  
//
//  Created by Назар Ткаченко on 16.12.2022.
//

import UIKit

protocol MenuTableAdapterOutputProtocol: AnyObject {
    func itemSelected(index: Int)
}

final class MenuTableAdapter: NSObject {
    
    var items: [Product] = []
    var categories: [String] = []
    weak var presenter: MenuTableAdapterOutputProtocol?
    weak var view: CategoriesViewDelegate?
}

//MARK: - DataSource, Delegate

extension MenuTableAdapter: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.itemSelected(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Layout.categoryHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let categoriesView = CategoriesView(categories: categories)
        categoriesView.delegate = view
        return categoriesView
    }
}

extension MenuTableAdapter {
    struct Layout {
        static let categoryHeight: CGFloat = 50
    }
}

extension MenuTableAdapter: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductCell.reuseID, for: indexPath) as? ProductCell else { return UITableViewCell() }
        let product = items[indexPath.row]
        cell.configure(model: product)
        
        return cell
    }
}

