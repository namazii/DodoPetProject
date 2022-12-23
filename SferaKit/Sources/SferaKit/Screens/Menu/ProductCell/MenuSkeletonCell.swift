//
//  MenuSkeletonCell.swift
//  
//
//  Created by Назар Ткаченко on 21.12.2022.
//

import UIKit

class MenuSkeletonCell: UITableViewCell {
    
    static let reuseID = "MenuSkeletonCell"
    
    //MARK: - Private Properties
    private let productImageLayer = CAGradientLayer()
    private let productImageView: UIImageView = {
        let image = UIImageView()
                
        return image
    }()
    
    private let headLayer = CAGradientLayer()
    private let headLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private let infoLayer = CAGradientLayer()
    private let infoLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private let priceLayer = CAGradientLayer()
    private let priceButton: UIButton = {
        let button = UIButton()
        
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
        
        setupSkeleton()
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
        
        setupLayers()
    }
    
    //MARK: - Private Methods
    private func setupLayers() {
        headLayer.frame = headLabel.bounds
        headLayer.cornerRadius = headLabel.bounds.height / 2
        
        productImageLayer.frame = productImageView.bounds
        productImageLayer.cornerRadius = productImageView.bounds.height / 2
        
        infoLayer.frame = infoLabel.bounds
        infoLayer.cornerRadius = infoLabel.bounds.height / 3
        
        priceLayer.frame = priceButton.bounds
        priceLayer.cornerRadius = priceButton.bounds.height / 2
    }
    
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
        
        infoLabel.snp.makeConstraints { make in
            make.height.equalTo(contentView.snp.height).multipliedBy(0.4)
            make.width.equalTo(contentView.snp.width).multipliedBy(0.5)
        }
        
        priceButton.snp.makeConstraints { make in
            make.height.equalTo(stackViewMain.snp.height).multipliedBy(0.2)
            make.width.equalTo(stackViewMain.snp.width).multipliedBy(0.3)
        }
        
        headLabel.snp.makeConstraints { make in
            make.height.equalTo(stackViewMain.snp.height).multipliedBy(0.15)
            make.width.equalTo(stackViewMain.snp.width).multipliedBy(0.3)
        }
    }
}

//MARK: - SkeletonLoadable
extension MenuSkeletonCell: SkeletonLoadable {
    
    func setupSkeleton() {
        headLayer.startPoint = CGPoint(x: 0, y: 0.5)
        headLayer.endPoint = CGPoint(x: 1, y: 0.5)
        headLabel.layer.addSublayer(headLayer)
        
        infoLayer.startPoint = CGPoint(x: 0, y: 0.5)
        infoLayer.endPoint = CGPoint(x: 1, y: 0.5)
        infoLabel.layer.addSublayer(infoLayer)
        
        priceLayer.startPoint = CGPoint(x: 0, y: 0.5)
        priceLayer.endPoint = CGPoint(x: 1, y: 0.5)
        priceButton.layer.addSublayer(priceLayer)
        
        productImageLayer.startPoint = CGPoint(x: 0, y: 0.5)
        productImageLayer.endPoint = CGPoint(x: 1, y: 0.5)
        productImageView.layer.addSublayer(productImageLayer)
        
        let headGroup = makeAnimationGroup()
        headGroup.beginTime = 0.0
        headLayer.add(headGroup, forKey: "backgroundColor")
        
        let infoGroup = makeAnimationGroup(previousGroup: headGroup)
        infoLayer.add(infoGroup, forKey: "backgroundColor")
        
        let priceGroup = makeAnimationGroup(previousGroup: headGroup)
        priceLayer.add(priceGroup, forKey: "backgroundColor")
        
        let productImageGroup = makeAnimationGroup(previousGroup: headGroup)
        productImageLayer.add(productImageGroup, forKey: "backgroundColor")
    }
}

