//
//  BannersCell.swift
//  test-sfera
//
//  Created by Назар Ткаченко on 27.11.2022.
//

import UIKit
import SnapKit

final class BannersCell: UICollectionViewCell {
    
    static let reuseID = "BannersCell"
    
    //MARK: - Private Properties
    private let imageView: UIImageView = {
        let image = UIImageView()
        
        return image
    }()
    
    //MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Public Methods
    func configure(string: String) {
        imageView.image = UIImage(named: string, in: .module, with: nil)
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

