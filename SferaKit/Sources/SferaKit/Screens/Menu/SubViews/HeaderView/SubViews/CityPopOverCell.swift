//
//  CityPopOverCell.swift
//  test-sfera
//
//  Created by Назар Ткаченко on 27.11.2022.
//

import UIKit
import SnapKit

final class CityPopOverCell: UITableViewCell {
    static let reuseID = "CityPopOverCell"
    
    //MARK: - Private Methods
    private let cityLabel: UILabel = {
       let label = UILabel()
        
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 23)
        
        return label
    }()
    
    //MARK: - LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private Methods
    private func setupView(){
        backgroundColor = .systemBackground
        contentView.addSubview(cityLabel)
        cityLabel.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
    
    //MARK: - Public Methods
    func configure(city: String) {
        cityLabel.text = city
    }
}
