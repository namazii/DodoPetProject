//
//  DetailProductViewController.swift
//  DodoPetProject
//
//  Created by Назар Ткаченко on 27.11.2022.
//

import UIKit
import SnapKit

protocol DetailProductViewInputProtocol: AnyObject {
    func updateProduct(_ produc: Product?)
    func priceСalculation(_ product: Product)
}

protocol DetailProductViewOutputProtocol {
    func addToCart()
}

final class DetailProductViewController: UIViewController, ScreenRoutable {
    
    var presenter: DetailProductViewOutputProtocol?
    var rootView: DetailProductView
    
    //MARK: - LifeCycle
    init(rootView: DetailProductView, presenter: DetailProductViewOutputProtocol) {
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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        rootView.tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        rootView.orderButton.layer.cornerRadius = 25
    }
}

extension DetailProductViewController: DetailProductViewDelegateProtocol {
    //MARK: - Actions
    func addOrder() {
        presenter?.addToCart()
        dismissView(animated: true, completion: nil)
    }
}

//MARK: - DetailProductViewInputProtocol
extension DetailProductViewController: DetailProductViewInputProtocol {
    func priceСalculation(_ product: Product) {
        rootView.orderButton.setTitle("В корзину за \(product.price) р", for: .normal)
    }
    
    func updateProduct(_ produc: Product?) {
        rootView.tableAdapter.product = produc
    }
}

