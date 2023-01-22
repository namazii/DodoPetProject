//
//  CategorySkeletonCell.swift
//  DodoPetProject
//
//  Created by Назар Ткаченко on 21.12.2022.
//

import SnapKit
import UIKit

final class CategorySkeletonCell: UICollectionViewCell {
    
    static let reuseID = "CategorySkeletonCell"
    
    //MARK: - Private Properties
    private let titleLayer = CAGradientLayer()
    private let titleLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()

    //MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSkeleton()
        setupView()
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLayer.frame = titleLabel.bounds
        titleLayer.cornerRadius = titleLabel.bounds.height / 2
    }
    
    //MARK: - Private Methods
    private func setupView() {
        backgroundColor = .systemBackground
    }
    
    private func addSubviews() {
        addSubview(titleLabel)
    }
}

//MARK: - SetupConstraints
extension CategorySkeletonCell {
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8))
        }
    }
}

//MARK: - SkeletonLoadable
extension CategorySkeletonCell: SkeletonLoadable{
    
    private func setupSkeleton() {
        titleLayer.startPoint = CGPoint(x: 0, y: 0.5)
        titleLayer.endPoint = CGPoint(x: 1, y: 0.5)
        titleLabel.layer.addSublayer(titleLayer)
        
        let titleGroup = makeAnimationGroup()
        titleGroup.beginTime = 0.0
        titleLayer.add(titleGroup, forKey: "backgroundColor")
    }
}
