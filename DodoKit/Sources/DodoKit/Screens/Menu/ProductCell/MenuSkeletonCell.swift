//
//  MenuSkeletonCell.swift
//  DodoPetProject
//
//  Created by Назар Ткаченко on 21.12.2022.
//

import UIKit
import SnapKit

final class MenuSkeletonCell: UITableViewCell {
    
    static let reuseID = "MenuSkeletonCell"
    
    //MARK: - Private Properties
    private let productImageLayer = CAGradientLayer()
    private let productImageView: UIImageView = {
        let image = UIImageView(frame: .zero)
                
        return image
    }()
    
    private let headLayer = CAGradientLayer()
    private let headLabel: UILabel = {
        let label = UILabel(frame: .zero)
        
        return label
    }()
    
    private let infoLayer = CAGradientLayer()
    private let infoLabel: UILabel = {
        let label = UILabel(frame: .zero)
        
        return label
    }()
    
    private let priceLayer = CAGradientLayer()
    private let priceButton: UIButton = {
        let button = UIButton(frame: .zero)
        
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
        
        setupSkeleton()
        addSubviews()
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
    
    private func addSubviews() {
        contentView.addSubview(productImageView)
        contentView.addSubview(stackViewMain)
        
        stackViewMain.addArrangedSubview(headLabel)
        stackViewMain.addArrangedSubview(infoLabel)
        stackViewMain.addArrangedSubview(priceButton)
    }
}

//MARK: - MenuSkeletonCell
extension MenuSkeletonCell {
    
    private struct Appearance {
        static let padding = 16
        static let stackViewLeft = -20
        static let infoLabelHeight = 0.4
        static let infoLabelWidth = 0.4
        static let priceButtonHeight = 0.2
        static let priceButtonWidth = 0.3
        static let headLabelHeight = 0.15
        static let headLabelWidth = 0.3
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
        
        infoLabel.snp.makeConstraints { make in
            make.height.equalTo(contentView.snp.height).multipliedBy(Appearance.infoLabelHeight)
            make.width.equalTo(contentView.snp.width).multipliedBy(Appearance.infoLabelWidth)
        }
        
        priceButton.snp.makeConstraints { make in
            make.height.equalTo(stackViewMain.snp.height).multipliedBy(Appearance.priceButtonHeight)
            make.width.equalTo(stackViewMain.snp.width).multipliedBy(Appearance.priceButtonWidth)
        }
        
        headLabel.snp.makeConstraints { make in
            make.height.equalTo(stackViewMain.snp.height).multipliedBy(Appearance.headLabelHeight)
            make.width.equalTo(stackViewMain.snp.width).multipliedBy(Appearance.headLabelWidth)
        }
    }
}

//MARK: - SkeletonLoadable
extension MenuSkeletonCell: SkeletonLoadable {
    
    private func setupSkeleton() {
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

