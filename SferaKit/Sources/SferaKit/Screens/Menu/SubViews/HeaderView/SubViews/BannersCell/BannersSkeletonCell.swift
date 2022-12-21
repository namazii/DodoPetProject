//
//  BannersSkeletonCell.swift
//  
//
//  Created by Назар Ткаченко on 21.12.2022.
//

import UIKit
import SnapKit

final class BannersSkeletonCell: UICollectionViewCell {
    
    static let reuseID = "BannersSkeletonCell"
    
    //MARK: - Private Properties
    private let imageLayer = CAGradientLayer()
    private let imageView: UIImageView = {
        let image = UIImageView()
        
        
        return image
    }()
    
    //MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSkeleton()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageLayer.frame = imageView.bounds
        imageLayer.cornerRadius = imageView.bounds.height / 5
    }
    //MARK: - Private Methods
    private func setupView() {
        backgroundColor = .systemBackground
        
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

//MARK: - SkeletonLoadable
extension BannersSkeletonCell: SkeletonLoadable{
    func setupSkeleton() {
        imageLayer.startPoint = CGPoint(x: 0, y: 0.5)
        imageLayer.endPoint = CGPoint(x: 1, y: 0.5)
        imageView.layer.addSublayer(imageLayer)
        
        let imageGroup = makeAnimationGroup()
        imageGroup.beginTime = 0.0
        imageLayer.add(imageGroup, forKey: "backgroundColor")
    }
}
