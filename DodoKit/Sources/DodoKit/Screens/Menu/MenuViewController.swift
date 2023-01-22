//
//  MenuViewController.swift
//  DodoPetProject
//
//  Created by Назар Ткаченко on 27.11.2022.
//

import UIKit
import SnapKit

protocol MenuViewInputProtocol: AnyObject {
    func updateBanners(_ banners: [String])
    func updateProducts(_ products: [Product])
    func updateCategories(_ categories: [String])
}

protocol MenuViewOutputProtocol {
    func fetchProducts()
    func fetchCategories()
    func itemSelected(index: Int)
    var products: [Product] {get set}
}

final class MenuViewController: UIViewController, ScreenRoutable {
    
    var presenter: MenuViewOutputProtocol
    var rootView: MenuView
    
    //MARK: - LifeCycle
    init(rootView: MenuView, presenter: MenuViewOutputProtocol) {
        self.rootView = rootView
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rootView.delegate = self
        presenter.fetchProducts()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

//MARK: - CategoriesViewDelegate
extension MenuViewController: CategoriesViewDelegate {
    func scrollToRow(with category: String) {
        guard let index = presenter.products.firstIndex(where: {$0.category == category}) else { return }
        rootView.tableView.scrollToRow(at: IndexPath(row: index, section: 0) , at: .top, animated: true)
    }
}

//MARK: - MenuTableAdapterOutputProtocol
extension MenuViewController: MenuTableAdapterOutputProtocol {
    func itemSelected(index: Int) {
        presenter.itemSelected(index: index)
    }
}

//MARK: - UIPopoverPresentationControllerDelegate
extension MenuViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

//MARK: - CityPopOverViewOutputProtocol
extension MenuViewController: CityPopOverViewOutputProtocol {
    func selectedСity(_ string: String) {
        rootView.cityLabel.animateViewPress()
        rootView.cityLabel.text = string
    }
}

//MARK: - MenuViewInputProtocol
extension MenuViewController: MenuViewInputProtocol {
    
    func updateProducts(_ products: [Product]) {
        rootView.tableView.allowsSelection = true
        rootView.tableAdapter.items = products
        rootView.tableAdapter.loaded = true
        presenter.fetchCategories()
        rootView.tableView.reloadData()
    }
    
    func updateCategories(_ categories: [String]) {
        rootView.tableAdapter.categories = categories
        rootView.tableAdapter.loaded = true
        rootView.tableView.reloadData()
    }
    
    func updateBanners(_ banners: [String]) {
        rootView.bannerHeaderView.update(bannersString: banners)
        rootView.tableView.reloadData()
    }
}

//MARK: - MenuViewDelegateProtocol
extension MenuViewController: MenuViewDelegateProtocol {
    
    func menuViewCityButtonTapped(imageView: UIImageView) {
        //MARK: - Actions
        
        let popOverCityVC = CityPopOverViewController()
        popOverCityVC.modalPresentationStyle = .popover
        popOverCityVC.preferredContentSize = CGSize(width: 200, height: 200)
        popOverCityVC.delegate = self
        
        guard let presentionVC = popOverCityVC.popoverPresentationController else { return }
        presentionVC.delegate = self
        presentionVC.sourceView = imageView
        presentionVC.permittedArrowDirections = .up
        presentionVC.sourceRect = CGRect(x: imageView.bounds.midX,
                                         y: imageView.bounds.midY, width: 0, height: 0)
        
        present(popOverCityVC, animated: true)
    }
}
