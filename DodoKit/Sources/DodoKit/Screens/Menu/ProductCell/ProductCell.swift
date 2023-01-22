//
//  ProductCell.swift
//  DodoPetProject
//
//  Created by Назар Ткаченко on 27.11.2022.
//

import UIKit
import SnapKit

final class ProductCell: UITableViewCell {
    
    static let reuseID = "ProductCell"
    
    //MARK: - Private Properties
    private let productImageView: UIImageView = {
        let image = UIImageView(frame: .zero)
        
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    
    private let headLabel: UILabel = {
        let label = UILabel(frame: .zero)
        
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        
        return label
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel(frame: .zero)
        
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .natural
        label.textColor = .gray
        label.sizeToFit()
        
        return label
    }()
    
    private let priceButton: UIButton = {
        let button = UIButton(frame: .zero)
        
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.9151502848, green: 0.5302934647, blue: 0.004759409465, alpha: 1)
        
        return button
    }()
    
    private let stackViewMain: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        
        return stackView
    }()
    
    //MARK: - LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        headLabel.font = .systemFont(ofSize: contentView.frame.height / 8.4)
        infoLabel.font = .systemFont(ofSize: contentView.frame.height / 10)
        priceButton.layer.cornerRadius = priceButton.frame.height / 2
    }
    
    //MARK: - Public Methods
    func configure(model: Product) {
        headLabel.text = model.name
        infoLabel.text = model.itemDescription
        priceButton.setTitle(" \(model.price) р", for: .normal)
        productImageView.image = UIImage(named: model.image, in: .module, with: nil)
    }
    
    //MARK: - Private Methods
    private func addSubviews() {
        contentView.addSubview(productImageView)
        contentView.addSubview(stackViewMain)
        
        stackViewMain.addArrangedSubview(headLabel)
        stackViewMain.addArrangedSubview(infoLabel)
        stackViewMain.addArrangedSubview(priceButton)
    }
}

//MARK: - SetupConstraints
extension ProductCell {
    
    private struct Appearance {
        static let padding = 16
        static let stackViewLeft = -20
        static let priceButtonHeight = 0.22
        static let priceButtonWidth = 0.5
        static let headLabelHeight = 0.15
    }
    
    private func setupConstraints() {
        productImageView.snp.makeConstraints { make in
            make.height.equalTo(productImageView.snp.width)
            make.leading.top.bottom.equalTo(contentView).inset(Appearance.padding)
        }
        
        stackViewMain.snp.makeConstraints { make in
            make.leading.equalTo(productImageView.snp.trailing).inset(Appearance.stackViewLeft)
            make.top.trailing.bottom.equalTo(contentView).inset(Appearance.padding)
        }
        
        priceButton.snp.makeConstraints { make in
            make.height.equalTo(stackViewMain.snp.height).multipliedBy(Appearance.priceButtonHeight)
            make.width.equalTo(stackViewMain.snp.width).multipliedBy(Appearance.priceButtonWidth)
        }
        
        headLabel.snp.makeConstraints { make in
            make.height.equalTo(stackViewMain.snp.height).multipliedBy(Appearance.headLabelHeight)
        }
    }
}
