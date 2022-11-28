//
//  ProductIngredientsCell.swift
//  test-sfera
//
//  Created by Назар Ткаченко on 27.11.2022.
//

//import UIKit
//
////MARK: - Protocol
//protocol ProductIngredientsCellDelegate: AnyObject {
//    func selectProductIngredientsSize(string: String)
//    func selectProductIngredientsSugar(bool: Bool)
//    func selectProductIngredientsCinnamon(bool: Bool)
//}
//
//class ProductIngredientsCell: UITableViewCell {
//    
//    static let reuseID = "ProductIngredientsCell"
//    
//    weak var delegate: ProductIngredientsCellDelegate?
//    
//    //MARK: Private Methods
//    private lazy var sizeSegmentControl: UISegmentedControl = {
//        let segment = UISegmentedControl(items: ["Маленький", "Средний", "Большой"])
//        
//        segment.addTarget(self, action: #selector(sizeSelected), for: .valueChanged)
//        
//        return segment
//    }()
//    
//    private lazy var sugarSegmentControl: UISegmentedControl = {
//        let segment = UISegmentedControl(items: ["Без сахара", "С сахаром"])
//        
//        segment.addTarget(self, action: #selector(sugarSelected), for: .valueChanged)
//        
//        return segment
//    }()
//    
//    private lazy var cinnamonSegmentControl: UISegmentedControl = {
//        let segment = UISegmentedControl(items: ["Без корицы", "С корицей"])
//        
//        segment.addTarget(self, action: #selector(cinnamonSelected), for: .valueChanged)
//        
//        return segment
//    }()
//    
//    //MARK: - LifeCycle
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        
//        setupViews()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    //MARK: - Actions
//    @objc private func sizeSelected(_ sender: UISegmentedControl) {
//        switch sender.selectedSegmentIndex {
//        case 0:
//            delegate?.selectProductIngredientsSize(string: "Маленький")
//        case 1:
//            delegate?.selectProductIngredientsSize(string: "Средний")
//        default:
//            delegate?.selectProductIngredientsSize(string: "Большой")
//        }
//    }
//    
//    @objc private func sugarSelected(_ sender: UISegmentedControl) {
//        switch sender.selectedSegmentIndex {
//        case 0:
//            delegate?.selectProductIngredientsSugar(bool: false)
//        default:
//            delegate?.selectProductIngredientsSugar(bool: true)
//        }
//    }
//    
//    @objc private func cinnamonSelected(_ sender: UISegmentedControl) {
//        switch sender.selectedSegmentIndex {
//        case 0:
//            delegate?.selectProductIngredientsCinnamon(bool: false)
//        default:
//            delegate?.selectProductIngredientsCinnamon(bool: true)
//        }
//    }
//    
//    //MARK: - Private Methods
//    private func setupViews() {
//        contentView.addSubview(sizeSegmentControl)
//        sizeSegmentControl.snp.makeConstraints { make in
//            make.top.left.right.equalToSuperview()
//            make.height.equalToSuperview().multipliedBy(0.27)
//        }
//        
//        contentView.addSubview(sugarSegmentControl)
//        sugarSegmentControl.snp.makeConstraints { make in
//            make.top.equalTo(sizeSegmentControl.snp.bottom).offset(10)
//            make.left.right.equalToSuperview()
//            make.height.equalToSuperview().multipliedBy(0.27)
//        }
//        
//        contentView.addSubview(cinnamonSegmentControl)
//        cinnamonSegmentControl.snp.makeConstraints { make in
//            make.top.equalTo(sugarSegmentControl.snp.bottom).offset(10)
//            make.left.right.equalToSuperview()
//            make.height.equalToSuperview().multipliedBy(0.27)
//        }
//    }
//}
