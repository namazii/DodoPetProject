//
//  ProductInfoCell.swift
//  test-sfera
//
//  Created by Назар Ткаченко on 27.11.2022.
//

import UIKit

final class ProductInfoCell: UITableViewCell {
    
    static let reuseID = "ProductInfoCell"
    
    //MARK: - Private Properties
    private let nameLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 20)
        label.text = "Сырная"
        
        return label
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.textColor = .gray
        label.sizeToFit()
        label.font = .systemFont(ofSize: 14)
        label.text = "Ветчина,шампиньоны, увеличинная порция моцареллы, томатный соус"
        
        return label
    }()
    
    //MARK: - LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    override func layoutSubviews() {
        nameLabel.font = .systemFont(ofSize: contentView.frame.height / 3)
        infoLabel.font = .systemFont(ofSize: contentView.frame.height / 5)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public Methods
    func configure(product: Product?) {
        nameLabel.text = product?.name
        infoLabel.text = product?.itemDescription
    }
    
    //MARK: - Private Methods
    private func setupViews() {
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        
        contentView.addSubview(infoLabel)
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom)
            make.left.right.bottom.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.6)
        }
    }
}
