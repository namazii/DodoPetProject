//
//  CartSteperView.swift
//  test-sfera
//
//  Created by Назар Ткаченко on 28.11.2022.
//

import UIKit
import SnapKit

protocol CartSteperDelegateProtocol: AnyObject {
    var steperCounter: Int {get set}
}

class CartSteperView: UIView {
    
    var steperCounter = 1 {
        didSet {
            chaingLabel()
        }
    }
    
    private lazy var countLabel: UILabel = {
        let label = UILabel()
        
        label.text = "1"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        
        return label
    }()
    
    private lazy var increaseButton: UIButton = {
       let button = UIButton()
        
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.addTarget(self, action: #selector(didTapSteperButton), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var decreaseButton: UIButton = {
       let button = UIButton()
        
        button.setImage(UIImage(systemName: "minus"), for: .normal)
        button.addTarget(self, action: #selector(didTapSteperButton), for: .touchUpInside)
        
        return button
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 15
        
        return stackView
    }()
    
    private let steperBackView: UIView = {
        let backView = UIView()
        
        backView.backgroundColor = .red
        
        return backView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        steperBackView.layer.cornerRadius = self.bounds.height / 3
        
    }
    
    private func chaingLabel() {
        countLabel.text = String(steperCounter)
    }
    
    private func setupViews() {
        self.backgroundColor = .systemBackground
        self.addSubview(steperBackView)
        steperBackView.addSubview(stackView)
        stackView.addArrangedSubview(increaseButton)
        stackView.addArrangedSubview(countLabel)
        stackView.addArrangedSubview(decreaseButton)
    }
    
    private func setupConstraints() {
        steperBackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        increaseButton.snp.makeConstraints { make in
            make.left.equalTo(stackView.snp.left).inset(10)
//            make.width.e
        }
        
        decreaseButton.snp.makeConstraints { make in
            make.right.equalTo(stackView.snp.right).inset(10)
        }
    }
    
    //MARK: - Action
    @objc private func didTapSteperButton(_ button: UIButton) {
        switch button {
        case increaseButton:
            steperCounter += 1
        default:
            if steperCounter != 0 {
                steperCounter -= 1
            }
        }
    }
}
