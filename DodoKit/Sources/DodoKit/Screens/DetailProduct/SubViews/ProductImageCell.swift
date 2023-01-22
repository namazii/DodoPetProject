//
//  ProductImageCell.swift
//  DodoPetProject
//
//  Created by Назар Ткаченко on 27.11.2022.
//

import UIKit
import SnapKit

final class ProductImageCell: UITableViewCell {
    
    static let reuseID = "ProductImageCell"
    
    //MARK: - Private Properties
    private let productImage: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        
        imageView.contentMode = .scaleAspectFit
        
        return imageView
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
    
    //MARK: - Private Properties
    private func addSubviews() {
        contentView.addSubview(productImage)
    }
    
    //MARK: - Public Properties
    func configure(image: String) {
        productImage.image = UIImage(named: image, in: .module, with: nil)
    }
}

//MARK: - SetupConstraints
extension ProductImageCell {
    
    private struct Appearance {
        static let negativePadding = -20
        static let positivePadding = 20
    }
    
    private func setupConstraints() {
        productImage.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(Appearance.positivePadding)
            make.bottom.trailing.equalToSuperview().offset(Appearance.negativePadding)
        }
    }
}
