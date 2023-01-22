//
//  MenuView.swift
//  DodoPetProject
//
//  Created by Назар Ткаченко on 29.12.2022.
//

import UIKit
import SnapKit

protocol MenuViewDelegateProtocol: AnyObject {
    func menuViewCityButtonTapped(imageView: UIImageView)
}

class MenuView: UIView {
    
    weak var delegate: MenuViewDelegateProtocol?
    
    var tableAdapter: MenuTableAdapter
    
    //MARK: - CityLabel
    let cityLabel = UILabel(text: "Москва")
    private let chevronImageView = UIImageView(image: UIImage(named: "chevron", in: .module, with: nil))
    private lazy var chooseCityView: UIView = {
        let view = UIView(frame: .zero)
        
        view.backgroundColor = .clear
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(cityButtonTapped)))
        
        return view
    }()
    
    //MARK: - BannersView
    lazy var bannerHeaderView: BannersView = {
        let width = UIView.screenWidth
        let height = width * 0.3
        let bannerView = BannersView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        return bannerView
    }()
    
    //MARK: - TableView
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        
        tableView.allowsSelection = false
        tableView.register(ProductCell.self, forCellReuseIdentifier: ProductCell.reuseID)
        tableView.register(MenuSkeletonCell.self, forCellReuseIdentifier: MenuSkeletonCell.reuseID)
        tableView.dataSource = tableAdapter
        tableView.delegate = tableAdapter
        tableView.tableHeaderView = bannerHeaderView
        tableView.separatorStyle = .none
        
        return tableView
    }()
    
    //MARK: - LifeCycle
    init(tableAdapter: MenuTableAdapter) {
        self.tableAdapter = tableAdapter
        super.init(frame: UIScreen.main.bounds)
        setuView()
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tableView.rowHeight = bounds.height / 5
    }
    
    //MARK: - Private Methods
    private func setuView() {
        backgroundColor = .systemBackground
    }
    
    private func addSubviews() {
        addSubview(cityLabel)
        addSubview(chevronImageView)
        addSubview(chooseCityView)
        addSubview(tableView)
    }
    
    //MARK: - Actions
    @objc private func cityButtonTapped() {
        delegate?.menuViewCityButtonTapped(imageView: chevronImageView)
    }
}

extension MenuView {
    
    private struct Appearance {
        static let leftPadding = 16
        static let chevronWidth = 14
        static let chevronHeight = 8
        static let tableTop = 24
    }
    
    private func setupConstraints() {
        
        cityLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.equalToSuperview().offset(Appearance.leftPadding)
        }
        
        chevronImageView.snp.makeConstraints { make in
            make.centerY.equalTo(cityLabel)
            make.leading.equalTo(cityLabel.snp.trailing).offset(8)
            make.size.equalTo(CGSize(width: Appearance.chevronWidth, height: Appearance.chevronHeight))
        }
        
        chooseCityView.snp.makeConstraints { make in
            make.top.bottom.leading.equalTo(cityLabel)
            make.trailing.equalTo(chevronImageView)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(chooseCityView.snp.bottom).offset(Appearance.tableTop)
            make.bottom.equalTo(safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
    }
}
