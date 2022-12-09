//
//  CartViewController.swift
//  test-sfera
//
//  Created by Назар Ткаченко on 27.11.2022.
//

import UIKit
import SnapKit

protocol CartViewInputProtocol: AnyObject {
}

protocol CartViewOutputProtocol {
    var products: [Product] {get set}
    func getCart()
    func didTapShowProductDetailCell()
    func updateProducts()
}

class CartViewController: UIViewController {

    //MARK: - Private Properties
    private let assembly: CartAssemblyInputProtocol = CartAssembly()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.register(CartCell.self, forCellReuseIdentifier: CartCell.reuseID)
        tableView.dataSource = self
        //tableView.delegate = self
//        tableView.separatorStyle = .none
        
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
    
    //MARK: - Public Properties
    var presenter: CartViewOutputProtocol?
    

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        assembly.configure(withView: self)
        
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
//        guard let product = product else { return }
//        CartService.shared.addProduct(model: product)
//        presentingViewController?.dismiss(animated: true)
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
    
}

//MARK: - UITableViewDelegate
extension CartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.products.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CartCell.reuseID, for: indexPath) as? CartCell else { return UITableViewCell() }
        guard let products = presenter?.products[indexPath.row] else { return CartCell() }
        
        cell.selectionStyle = .none
        cell.delegate = self
        cell.configure(model: products)
        
        return cell
    }
}

//MARK: - CartCellDelegate
extension CartViewController: CartCellDelegate {
    func cartCell(counter: Int, product: Product) {
        
        guard let productIndex = presenter?.products.firstIndex(where: {$0.id == product.id }) else { return }
        
        presenter?.products[productIndex].count = counter
        
        presenter?.updateProducts()
        
        if counter == 0 {
            presenter?.products.remove(at: productIndex)
            
            tableView.reloadData()
        }
        
    }
}
