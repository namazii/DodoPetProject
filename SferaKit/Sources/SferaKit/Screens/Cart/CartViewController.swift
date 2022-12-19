//
//  CartViewController.swift
//  test-sfera
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
}

final class CartViewController: UIViewController, ScreenRoutable {
    
    var presenter: CartViewOutputProtocol?
    
    var tableAdapter: CartTableAdapter
    
    init(tableAdapter: CartTableAdapter) {
        self.tableAdapter = tableAdapter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private Properties
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.register(CartCell.self, forCellReuseIdentifier: CartCell.reuseID)
        tableView.dataSource = tableAdapter
        
        return tableView
    }()
    
    private lazy var backgroundButtonView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .systemBackground
        view.layer.borderWidth = 1
        view.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        return view
    }()
    
    private lazy var orderButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("Оформить заказ на 300$", for: .normal)
        button.tintColor = .white
        button.backgroundColor = #colorLiteral(red: 1, green: 0.4541721344, blue: 0.01430354454, alpha: 1)
        button.addTarget(self, action: #selector(addOrder), for: .touchUpInside)
        
        return button
    }()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        presenter?.getCart()
        tableView.reloadData()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        tableView.rowHeight = view.bounds.height / 5
        orderButton.layer.cornerRadius = orderButton.bounds.height / 2
    }
    
    //MARK: - Actions
    @objc private func addOrder() {
        presenter?.didTapOrderButton()
    }
    
    //MARK: - Private Methods
    private func setupView() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        
        view.addSubview(backgroundButtonView)
        backgroundButtonView.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.height.equalToSuperview().multipliedBy(0.1)
        }

        
        backgroundButtonView.addSubview(orderButton)
        orderButton.snp.makeConstraints { make in
            make.left.right.equalTo(backgroundButtonView).inset(20)
            make.top.bottom.equalTo(backgroundButtonView).inset(15)
        }
    }
}

//MARK: - CartViewInputProtocol
extension CartViewController: CartViewInputProtocol {
    func updateProducts(_ products: [Product]) {
        tableAdapter.products = products
    }
    
    func tableReloadData() {
        tableView.reloadData()
    }
    
    func getTotalPrice(price: String) {
        orderButton.setTitle(price, for: .normal)
    }
}
