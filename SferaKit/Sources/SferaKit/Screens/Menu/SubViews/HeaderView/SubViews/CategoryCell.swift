//
//  CategoryCell.swift
//  test-sfera
//
//  Created by Назар Ткаченко on 27.11.2022.
//

import SnapKit
import UIKit

final class CategoryCell: UICollectionViewCell {
    
    static let reuseID = "CategoryCell"
    
    //MARK: - Private Properties
    private let titleLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 1
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.textColor = UIColor(red: 0.992, green: 0.227, blue: 0.412, alpha: 0.4)
        
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                contentView.backgroundColor = UIColor(red: 0.992, green: 0.227, blue: 0.412, alpha: 0.2)
                titleLabel.textColor = UIColor(red: 0.992, green: 0.227, blue: 0.412, alpha: 1)
            } else {
                contentView.backgroundColor = .systemBackground
                titleLabel.textColor = UIColor(red: 0.992, green: 0.227, blue: 0.412, alpha: 0.4)
            }
        }
    }
    
    //MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private Methods
    private func setupViews() {
        backgroundColor = .systemBackground
        
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor(red: 0.992, green: 0.227, blue: 0.412, alpha: 0.4).cgColor
        contentView.layer.cornerRadius = contentView.frame.height / 2
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8))
        }
    }
    
    //MARK: - Public Methods
    func configure(category: String) {
        titleLabel.text = category
    }
}
