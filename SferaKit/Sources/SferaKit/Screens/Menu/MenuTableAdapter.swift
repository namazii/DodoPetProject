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
    var loaded = false
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
        let categoriesView = CategoriesView(categories: categories, loaded: loaded)
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
        if loaded {
            return items.count
        } else {
         return 4
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if loaded {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductCell.reuseID, for: indexPath) as? ProductCell else { return UITableViewCell() }
            
            let product = items[indexPath.row]
            cell.configure(model: product)
            cell.selectionStyle = .none
            
            return cell
            
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MenuSkeletonCell.reuseID, for: indexPath) as? MenuSkeletonCell else { return  UITableViewCell() }
            
            cell.selectionStyle = .none
            
            return cell
        }
    }
}

