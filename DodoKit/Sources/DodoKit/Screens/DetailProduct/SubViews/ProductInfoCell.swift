//
//  ProductInfoCell.swift
//  DodoPetProject
//
//  Created by Назар Ткаченко on 27.11.2022.
//

import UIKit
import SnapKit

final class ProductInfoCell: UITableViewCell {
    
    static let reuseID = "ProductInfoCell"
    
    //MARK: - Private Properties
    private let nameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 20)
        
        return label
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel(frame: .zero)
        
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.textColor = .gray
        label.sizeToFit()
        label.font = .systemFont(ofSize: 14)
        
        return label
    }()
    
    //MARK: - LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubviews()
        setupConstraints()
    }
    
    override func layoutSubviews() {
        nameLabel.font = .systemFont(ofSize: contentView.frame.height / 2.5)
        infoLabel.font = .systemFont(ofSize: contentView.frame.height / 3.5)
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
    private func addSubviews() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(infoLabel)
    }
}

//MARK: - SetupConstraints
extension ProductInfoCell {
    
    private struct Appearance {
        static let negativePadding = -20
        static let positivePadding = 20
        static let infoLabelTopPadding = 10
    }
    
    private func setupConstraints() {
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(Appearance.positivePadding)
            make.trailing.equalToSuperview().offset(Appearance.negativePadding)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(Appearance.infoLabelTopPadding)
            make.leading.equalToSuperview().offset(Appearance.positivePadding)
            make.trailing.equalToSuperview().offset(Appearance.negativePadding)
        }
    }
}
