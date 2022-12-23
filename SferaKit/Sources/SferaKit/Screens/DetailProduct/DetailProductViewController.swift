//
//  DetailProductViewController.swift
//  test-sfera
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
    
    var tableAdapter: DetailProductTableAdapter
    
    init(tableAdapter: DetailProductTableAdapter) {
        self.tableAdapter = tableAdapter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private Properties
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.register(ProductImageCell.self, forCellReuseIdentifier: ProductImageCell.reuseID)
        tableView.register(ProductInfoCell.self, forCellReuseIdentifier: ProductInfoCell.reuseID)
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.dataSource = tableAdapter
        tableView.delegate = tableAdapter
        
        return tableView
    }()
    
    private lazy var backgroundButtonView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .clear
        
        return view
    }()
    
    private lazy var orderButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("В корзину за 300$", for: .normal)
        button.tintColor = .white
        button.backgroundColor = #colorLiteral(red: 1, green: 0.4541721344, blue: 0.01430354454, alpha: 1)
        button.addTarget(self, action: #selector(addOrder), for: .touchUpInside)
        
        return button
    }()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        orderButton.layer.cornerRadius = 25
    }
    
    //MARK: - Actions
    @objc private func addOrder() {
        presenter?.addToCart()
        dismissView(animated: true, completion: nil)
    }
    
    //MARK: - Private Methods
    private func setupViews() {
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
            make.height.equalTo(80)
        }
        
        backgroundButtonView.addSubview(orderButton)
        orderButton.snp.makeConstraints { make in
            make.left.right.equalTo(backgroundButtonView).inset(20)
            make.top.bottom.equalTo(backgroundButtonView).inset(15)
        }
    }
}

//MARK: - DetailProductViewInputProtocol
extension DetailProductViewController: DetailProductViewInputProtocol {
    func priceСalculation(_ product: Product) {
        orderButton.setTitle("В корзину за \(product.price) р", for: .normal)
    }
    
    func updateProduct(_ produc: Product?) {
        tableAdapter.product = produc
    }
}

