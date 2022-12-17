//
//  CartSteperView.swift
//  test-sfera
//
//  Created by Назар Ткаченко on 28.11.2022.
//

import UIKit
import SnapKit

protocol CartSteperViewDelegate: AnyObject {
    func carStepperView(_ stepperCounter: Int )
}

final class CartSteperView: UIView {
    
    var steperCounter = 1 {
        didSet {
            countLabel.text = String(steperCounter)
        }
    }
    
    weak var delegate: CartSteperViewDelegate?
    
    //MARK: - Private Properties
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
        button.tintColor = #colorLiteral(red: 0.5255012512, green: 0.5412146449, blue: 0.5883281827, alpha: 1)
        button.addTarget(self, action: #selector(didTapSteperButton), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var decreaseButton: UIButton = {
       let button = UIButton()
        
        button.setImage(UIImage(systemName: "minus"), for: .normal)
        button.tintColor = #colorLiteral(red: 0.5255012512, green: 0.5412146449, blue: 0.5883281827, alpha: 1)
        button.addTarget(self, action: #selector(didTapSteperButton), for: .touchUpInside)
        
        return button
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        stackView.spacing = 15
        
        return stackView
    }()
    
    private let steperBackView: UIView = {
        let backView = UIView()
        
        backView.backgroundColor = #colorLiteral(red: 0.964720428, green: 0.964720428, blue: 0.9843518138, alpha: 1)
        
        return backView
    }()
    
    //MARK: - LifeCycle
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
        steperBackView.layer.cornerRadius = self.bounds.height / 2
    }
    
    //MARK: - Private Methods
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
            make.top.bottom.equalToSuperview()
            make.left.equalTo(steperBackView.snp.left).inset(20)
            make.right.equalTo(steperBackView.snp.right).inset(20)
        }
    }
    
    //MARK: - Action
    @objc private func didTapSteperButton(_ button: UIButton) {
        switch button {
        case increaseButton:
            steperCounter += 1
            delegate?.carStepperView(steperCounter)
        default:
            if steperCounter != 0 {
                steperCounter -= 1
                delegate?.carStepperView(steperCounter)
            }
        }
    }
}
