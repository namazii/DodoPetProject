//
//  ProductCell.swift
//  test-sfera
//
//  Created by Назар Ткаченко on 27.11.2022.
//

import UIKit
import SnapKit

class ProductCell: UITableViewCell {

    static let reuseID = "ProductCell"
    
    //MARK: - Private Properties
    private let productImageView: UIImageView = {
        let image = UIImageView()
        
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    
    private let headLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20)
        label.text = "Ветчина и грибы"
        
        return label
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .natural
        label.textColor = .gray
        label.sizeToFit()
        label.font = .systemFont(ofSize: 14)
        label.text = "Ветчина,шампиньоны, увеличинная порция моцареллы, томатный соус"
        
        return label
    }()
    
    private let priceButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("   от 100р   ", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.9151502848, green: 0.5302934647, blue: 0.004759409465, alpha: 1)
        
        return button
    }()
    
    private let stackViewMain: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        
        return stackView
    }()
    
    //MARK: - LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        headLabel.font = .systemFont(ofSize: contentView.frame.height / 8.4)
        infoLabel.font = .systemFont(ofSize: contentView.frame.height / 11)
        priceButton.layer.cornerRadius = priceButton.frame.height / 2
    }
    
    //MARK: - Private Methods
    private func setupViews() {
        contentView.addSubview(productImageView)
        contentView.addSubview(stackViewMain)
        
        stackViewMain.addArrangedSubview(headLabel)
        stackViewMain.addArrangedSubview(infoLabel)
        stackViewMain.addArrangedSubview(priceButton)
    }
    
    private func setupConstraints() {
        productImageView.snp.makeConstraints { make in
            make.height.equalTo(productImageView.snp.width)
            make.left.top.bottom.equalTo(contentView).inset(16)
        }
        
        stackViewMain.snp.makeConstraints { make in
            make.left.equalTo(productImageView.snp.right).inset(-20)
            make.top.right.bottom.equalTo(contentView).inset(16)
        }
        
        priceButton.snp.makeConstraints { make in
            make.height.equalTo(stackViewMain.snp.height).multipliedBy(0.2)
        }
        
        headLabel.snp.makeConstraints { make in
            make.height.equalTo(stackViewMain.snp.height).multipliedBy(0.15)
        }
    }
    
    //MARK: - Public Methods
    func configure(model: Product) {
        headLabel.text = model.name
        infoLabel.text = model.itemDescription
        priceButton.setTitle("   От \(model.price)   ", for: .normal)
        productImageView.image = UIImage(named: model.image)
    }
}
