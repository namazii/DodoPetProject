//
//  CartView.swift
//  DodoPetProject
//
//  Created by Назар Ткаченко on 02.01.2023.
//

import UIKit
import SnapKit

protocol CartViewDelegateProtocol: AnyObject {
    func addOrder()
}

final class CartView: UIView {
    
    weak var delegate: CartViewDelegateProtocol?
    var tableAdapter: CartTableAdapter
    
    //MARK: - Private Properties
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        
        tableView.register(CartCell.self, forCellReuseIdentifier: CartCell.reuseID)
        tableView.dataSource = tableAdapter
        
        return tableView
    }()
    
    private lazy var backgroundButtonView: UIView = {
        let view = UIView(frame: .zero)
        
        view.backgroundColor = .systemBackground
        view.layer.borderWidth = 1
        view.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        return view
    }()
    
    lazy var orderButton: UIButton = {
        let button = UIButton(frame: .zero)
        
        button.tintColor = .white
        button.backgroundColor = #colorLiteral(red: 1, green: 0.4541721344, blue: 0.01430354454, alpha: 1)
        button.addTarget(self, action: #selector(addOrder), for: .touchUpInside)
        
        return button
    }()
    
    //MARK: - LifeCycle
    init(tableAdapter: CartTableAdapter) {
        self.tableAdapter = tableAdapter
        super.init(frame: UIScreen.main.bounds)
        setupView()
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tableView.rowHeight = bounds.height / 5
        orderButton.layer.cornerRadius = orderButton.bounds.height / 2
    }
    
    //MARK: - Actions
    @objc private func addOrder() {
        delegate?.addOrder()
    }
    
    //MARK: - Private Methods
    private func setupView() {
        backgroundColor = .systemBackground
    }
    
    private func addSubviews() {
        addSubview(tableView)
        addSubview(backgroundButtonView)
        backgroundButtonView.addSubview(orderButton)
    }
}

//MARK: - SetupConstraints
extension CartView {
    
    private struct Apperance {
        static let backgroundButtonViewHeight = 0.1
        static let orderButtonLeftPadding = 20
        static let orderButtonTopPadding = 15
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        backgroundButtonView.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide)
            make.height.equalToSuperview().multipliedBy(Apperance.backgroundButtonViewHeight)
        }
        
        orderButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(backgroundButtonView).inset(Apperance.orderButtonLeftPadding)
            make.top.bottom.equalTo(backgroundButtonView).inset(Apperance.orderButtonTopPadding)
        }
    }
}
