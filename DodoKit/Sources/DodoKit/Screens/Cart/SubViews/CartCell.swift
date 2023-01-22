//
//  CartCell.swift
//  DodoPetProject
//
//  Created by Назар Ткаченко on 27.11.2022.
//

import UIKit
import SnapKit

protocol CartCellDelegate: AnyObject {
    func cartCell(counter: Int, product: Product)
}

final class CartCell: UITableViewCell {
    
    static let reuseID = "CartCell"
    
    weak var delegate: CartCellDelegate?
    
    private var product: Product?
    
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
        label.font = .systemFont(ofSize: 20)
        
        return label
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel(frame: .zero)
        
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .natural
        label.textColor = .gray
        label.sizeToFit()
        label.font = .systemFont(ofSize: 14)
        
        return label
    }()
    
    private let steperView = CartSteperView(frame: .zero)
    
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
        
        infoLabel.font = .systemFont(ofSize: contentView.frame.height / 11)
    }
    
    //MARK: - Private Methods
    private func addSubviews() {
        contentView.addSubview(productImageView)
        contentView.addSubview(stackViewMain)
        stackViewMain.addArrangedSubview(headLabel)
        stackViewMain.addArrangedSubview(infoLabel)
        stackViewMain.addArrangedSubview(steperView)
        
        steperView.delegate = self
    }
    
    func configure(model: Product) {
        self.product = model
        productImageView.image = UIImage(named: model.image, in: .module, with: nil)
        headLabel.text = model.name
        infoLabel.text = model.itemDescription
        steperView.steperCounter = model.count
    }
}

//MARK: - CartSteperViewDelegate
extension CartCell: CartSteperViewDelegate {
    func carStepperView(_ stepperCounter: Int) {
        if let product = product {
            delegate?.cartCell(counter: stepperCounter, product: product)
        }
    }
}

extension CartCell {
    
    private struct Appearance {
        static let leftRightPadding = 16
        static let stackViewLeftPadding = -20
        static let headLabelHeight = 0.15
        static let steperHeight = 0.25
        static let steperWidth = 0.60
    }
    
    private func setupConstraints() {
        
        productImageView.snp.makeConstraints { make in
            make.height.equalTo(productImageView.snp.width)
            make.leading.top.bottom.equalTo(contentView).inset(Appearance.leftRightPadding)
        }
        
        stackViewMain.snp.makeConstraints { make in
            make.leading.equalTo(productImageView.snp.trailing).inset(Appearance.stackViewLeftPadding)
            make.top.trailing.bottom.equalTo(contentView).inset(Appearance.leftRightPadding)
        }
        
        headLabel.snp.makeConstraints { make in
            make.height.equalTo(stackViewMain.snp.height).multipliedBy(Appearance.headLabelHeight)
        }
        
        steperView.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(Appearance.steperHeight)
            make.width.equalToSuperview().multipliedBy(Appearance.steperWidth)
        }
    }
}
