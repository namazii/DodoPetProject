//
//  CartSteperView.swift
//  DodoPetProject
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
        let label = UILabel(frame: .zero)
        
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        
        return label
    }()
    
    private lazy var increaseButton: UIButton = {
        let button = UIButton(frame: .zero)
        
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = #colorLiteral(red: 0.5255012512, green: 0.5412146449, blue: 0.5883281827, alpha: 1)
        button.addTarget(self, action: #selector(didTapSteperButton), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var decreaseButton: UIButton = {
        let button = UIButton(frame: .zero)
        
        button.setImage(UIImage(systemName: "minus"), for: .normal)
        button.tintColor = #colorLiteral(red: 0.5255012512, green: 0.5412146449, blue: 0.5883281827, alpha: 1)
        button.addTarget(self, action: #selector(didTapSteperButton), for: .touchUpInside)
        
        return button
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        stackView.spacing = 15
        
        return stackView
    }()
    
    private let steperBackView: UIView = {
        let backView = UIView(frame: .zero)
        
        backView.backgroundColor = #colorLiteral(red: 0.964720428, green: 0.964720428, blue: 0.9843518138, alpha: 1)
        
        return backView
    }()
    
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        steperBackView.layer.cornerRadius = self.bounds.height / 2
    }
    
    //MARK: - Private Methods
    private func setupView() {
        backgroundColor = .systemBackground
    }
    
    private func addSubviews() {
        addSubview(steperBackView)
        steperBackView.addSubview(stackView)
        stackView.addArrangedSubview(increaseButton)
        stackView.addArrangedSubview(countLabel)
        stackView.addArrangedSubview(decreaseButton)
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

//MARK: - SetupConstraints
extension CartSteperView {
    
    private struct Appearance {
        static let padding = 20
    }
    
    private func setupConstraints() {
        steperBackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(steperBackView.snp.leading).inset(Appearance.padding)
            make.trailing.equalTo(steperBackView.snp.trailing).inset(Appearance.padding)
        }
    }
}
