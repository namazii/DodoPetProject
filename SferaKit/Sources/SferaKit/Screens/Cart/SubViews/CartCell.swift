//
//  CartCell.swift
//  test-sfera
//
//  Created by Назар Ткаченко on 27.11.2022.
//

import UIKit
import SnapKit

protocol CartCellDelegate: AnyObject {
    func cartCell(counter: Int, product: Product)
}

class CartCell: UITableViewCell {
    
    static let reuseID = "CartCell"
    
    weak var delegate: CartCellDelegate?
    
    var product: Product?
    
    private let productImageView: UIImageView = {
        let image = UIImageView()
        
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "pizza")
        
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
    
    private let steperView = CartSteperView()
    
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
    
    private func setupViews() {
        contentView.addSubview(productImageView)
        contentView.addSubview(stackViewMain)
        stackViewMain.addArrangedSubview(headLabel)
        stackViewMain.addArrangedSubview(infoLabel)
        stackViewMain.addArrangedSubview(steperView)
        
        steperView.delegate = self
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
        
        headLabel.snp.makeConstraints { make in
            make.height.equalTo(stackViewMain.snp.height).multipliedBy(0.15)
        }
        
        steperView.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.25)
            make.width.equalToSuperview().multipliedBy(0.60)
        }
    }
    
    func configure(model: Product) {
        self.product = model
        productImageView.image = UIImage(named: model.image)
        headLabel.text = model.name
        infoLabel.text = model.itemDescription
        steperView.steperCounter = model.count
    }
}

extension CartCell: CartSteperViewDelegate {
    
    func carStepperView(_ stepperCounter: Int) {
        if let product = product {
            delegate?.cartCell(counter: stepperCounter, product: product)
        }
        
    }
    
}
