//
//  CartViewController.swift
//  DodoPetProject
//
//  Created by Назар Ткаченко on 27.11.2022.
//

import UIKit
import SnapKit

protocol CartViewInputProtocol: AnyObject {
    func updateProducts(_ products: [Product])
    func getTotalPrice(price: String)
    func tableReloadData()
}

protocol CartViewOutputProtocol {
    func getCart()
    func didTapOrderButton()
    func sendProducts(_ products: [Product])
}

final class CartViewController: UIViewController, ScreenRoutable {
    
    var presenter: CartViewOutputProtocol?
    var rootView: CartView
    
    init(rootView: CartView, presenter: CartViewOutputProtocol) {
        self.rootView = rootView
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycle
    override func loadView() {
        self.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rootView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter?.getCart()
        rootView.tableView.reloadData()
    }
}

extension CartViewController: CartViewDelegateProtocol {
    //MARK: - Actions
    func addOrder() {
        presenter?.didTapOrderButton()
    }
}

//MARK: - CartTableAdapterOutputProtocol
extension CartViewController: CartTableAdapterOutputProtocol {
    
    func tableReloadData() {
        rootView.tableView.reloadData()
    }
    
    func sendProducts(_ products: [Product]) {
        presenter?.sendProducts(products)
    }
}

//MARK: - CartViewInputProtocol
extension CartViewController: CartViewInputProtocol {
    
    func updateProducts(_ products: [Product]) {
        rootView.tableAdapter.products = products
    }
    
    func getTotalPrice(price: String) {
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position.x"
        animation.values = [0, 10, -10, 10, 0]
        animation.keyTimes = [0, 0.16, 0.5, 0.83, 1]
        animation.duration = 0.4
        
        animation.isAdditive = true
        rootView.orderButton.layer.add(animation, forKey: "shake")
        
        if price == "0" {
            rootView.orderButton.isEnabled = false
            rootView.orderButton.setTitle("Добавьте продукты из меню", for: .normal)
        } else {
            rootView.orderButton.isEnabled = true
            rootView.orderButton.setTitle("Оформить заказ на \(price) р", for: .normal)
        }
    }
}
