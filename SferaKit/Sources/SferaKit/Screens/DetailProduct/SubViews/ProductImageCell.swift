//
//  ProductImageCell.swift
//  test-sfera
//
//  Created by Назар Ткаченко on 27.11.2022.
//

import UIKit

class ProductImageCell: UITableViewCell {
    
    static let reuseID = "ProductImageCell"
    
    //MARK: - Private Properties
    private let productImage: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    //MARK: - LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private Properties
    private func setupViews() {
        contentView.addSubview(productImage)
        productImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    //MARK: - Public Properties
    func configure(image: String) {
//        productImage.image = UIImage(named: image)
        productImage.image = UIImage(named: image, in: .module, with: nil)
    }
}
