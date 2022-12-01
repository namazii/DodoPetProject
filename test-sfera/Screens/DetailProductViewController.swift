//
//  DetailProductViewController.swift
//  test-sfera
//
//  Created by Назар Ткаченко on 27.11.2022.
//

import UIKit
import SnapKit

protocol DetailProductViewInputProtocol: AnyObject {
    func updateProduct()
}

protocol DetailProductViewOutputProtocol {
//    init(view: DetailProductViewInputProtocol)
    func loadView()
    var product: Product? {get set}
    func addToCart()
}

class DetailProductViewController: UIViewController {
    
    //MARK: - Enums
    enum SectionType: Int, CaseIterable {
        case image = 0
        case info = 1
//        case ingredients = 2
    }

    
    //MARK: - Private Properties
    private let assembly: DetailProductAssemblyInputProtocol = DetailProductAssembly()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.register(ProductImageCell.self, forCellReuseIdentifier: ProductImageCell.reuseID)
        tableView.register(ProductInfoCell.self, forCellReuseIdentifier: ProductInfoCell.reuseID)
//        tableView.register(ProductIngredientsCell.self, forCellReuseIdentifier: ProductIngredientsCell.reuseID)
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.dataSource = self
        tableView.delegate = self
        
        return tableView
    }()
    
    private lazy var backgroundButtonView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .clear
        
        return view
    }()
    
    private lazy var orderButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("В корзину за 300$", for: .normal)
        button.tintColor = .white
        button.backgroundColor = #colorLiteral(red: 1, green: 0.4541721344, blue: 0.01430354454, alpha: 1)
        button.addTarget(self, action: #selector(addOrder), for: .touchUpInside)
        
        return button
    }()
    
    //MARK: - Public Properties
    var presenter: DetailProductViewOutputProtocol?

    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadView()
        
        setupViews()
        priceСalculation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        orderButton.layer.cornerRadius = 25
    }
    
    //MARK: - Actions
    @objc private func addOrder() {
        presenter?.addToCart()
        presentingViewController?.dismiss(animated: true)
    }
    
    //MARK: - Private Methods
    private func priceСalculation() {
        guard let product = presenter?.product else { return }
        orderButton.setTitle("В корзину за \(product.price)$", for: .normal)
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        
        view.addSubview(backgroundButtonView)
        backgroundButtonView.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(80)
        }
        
        backgroundButtonView.addSubview(orderButton)
        orderButton.snp.makeConstraints { make in
            make.left.right.equalTo(backgroundButtonView).inset(20)
            make.top.bottom.equalTo(backgroundButtonView).inset(15)
        }
    }
}

//MARK: - DetailProductViewInputProtocol
extension DetailProductViewController: DetailProductViewInputProtocol {
    func updateProduct() {
        tableView.reloadData()
    }
}

//MARK: - Delegate, DataSource
extension DetailProductViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SectionType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let sectionType = SectionType.init(rawValue: indexPath.row)
        
        switch sectionType {
        case .image:
            
            return view.frame.height / 2
        case .info:
            return view.frame.height / 10
//        case .ingredients:
//            return 150
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionType = SectionType.init(rawValue: indexPath.row)
        
        switch sectionType {
        case .image:
            let imageCell = tableView.dequeueReusableCell(withIdentifier: ProductImageCell.reuseID)
            guard let cell = imageCell as? ProductImageCell else { return UITableViewCell() }
            
            cell.configure(image: presenter?.product?.image ?? "pizza1")
            return cell
        case .info:
            let infoCell = tableView.dequeueReusableCell(withIdentifier: ProductInfoCell.reuseID)
            guard let cell = infoCell as? ProductInfoCell else { return UITableViewCell() }
            
            cell.configure(product: presenter?.product)
            return cell
//        case.ingredients:
//            let ingredientsCell = tableView.dequeueReusableCell(withIdentifier: ProductIngredientsCell.reuseID)
//            guard let cell = ingredientsCell as? ProductIngredientsCell else { return UITableViewCell() }
//
//
//            cell.delegate = self
//
//            return cell
        default:
            return UITableViewCell()
        }
    }
    
}

////MARK: - ProductIngredientsCellDelegate
//extension DetailProductViewController: ProductIngredientsCellDelegate {
//
//    func selectProductIngredientsSize(string: String) {
//        print(string)
//        presenter?.product?.size = string
//    }
//
//    func selectProductIngredientsSugar(bool: Bool) {
//        print(bool)
//        presenter?.product?.sugar = bool
//    }
//
//    func selectProductIngredientsCinnamon(bool: Bool) {
//        print(bool)
//        presenter?.product?.cinnamon = bool
//    }
//}
