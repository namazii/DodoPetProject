//
//  DetailProductView.swift
//  DodoPetProject
//
//  Created by Назар Ткаченко on 03.01.2023.
//

import UIKit
import SnapKit

protocol DetailProductViewDelegateProtocol: AnyObject {
    func addOrder()
}

final class DetailProductView: UIView {
    
    weak var delegate: DetailProductViewDelegateProtocol?
    
    var tableAdapter: DetailProductTableAdapter
    
    //MARK: - Private Properties
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        
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
        let view = UIView(frame: .zero)
        
        view.backgroundColor = .clear
        
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
    init(tableAdapter: DetailProductTableAdapter) {
        self.tableAdapter = tableAdapter
        super.init(frame: UIScreen.main.bounds)
        setupView()
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    //MARK: - Actions
    @objc private func addOrder() {
        delegate?.addOrder()
    }
}

//MARK: - SetupConstraints
extension DetailProductView {
    
    private struct Appearance {
        static let backgroundButtonViewHeight = 80
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
            make.height.equalTo(Appearance.backgroundButtonViewHeight)
        }
        
        orderButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(backgroundButtonView).inset(Appearance.orderButtonLeftPadding)
            make.top.bottom.equalTo(backgroundButtonView).inset(Appearance.orderButtonTopPadding)
        }
    }
}
