//
//  CategoryCell.swift
//  DodoPetProject
//
//  Created by Назар Ткаченко on 27.11.2022.
//

import SnapKit
import UIKit

final class CategoryCell: UICollectionViewCell {
    
    static let reuseID = "CategoryCell"
    
    //MARK: - Private Properties
    private let titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        
        label.numberOfLines = 1
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .gray
        
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                contentView.backgroundColor = #colorLiteral(red: 0.9151502848, green: 0.5302934647, blue: 0.004759409465, alpha: 1)
                titleLabel.textColor = .white
            } else {
                contentView.backgroundColor = .systemBackground
                titleLabel.textColor = .black
            }
        }
    }
    
    //MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public Methods
    func configure(category: String) {
        titleLabel.text = category
    }
    
    //MARK: - Private Methods
    private func setupView() {
        backgroundColor = .systemBackground
        
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = #colorLiteral(red: 0.9151502848, green: 0.5302934647, blue: 0.004759409465, alpha: 1)
        contentView.layer.cornerRadius = contentView.frame.height / 2
    }
    private func addSubviews() {
        contentView.addSubview(titleLabel)
    }
}

//MARK: - SetupConstraints
extension CategoryCell {
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8))
        }
    }
}
