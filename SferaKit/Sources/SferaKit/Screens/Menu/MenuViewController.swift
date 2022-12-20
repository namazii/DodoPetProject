//
//  MenuViewController.swift
//  test-sfera
//
//  Created by Назар Ткаченко on 27.11.2022.
//

import UIKit
import SnapKit

protocol MenuViewInputProtocol: AnyObject {
    func updateBanners(_ banners: [String])
    func updateProducts(_ products: [Product])
    func updateCategories(_ categories: [String])
}

protocol MenuViewOutputProtocol {
    func fetchProducts()
//    func cityButtonTapped()
    func fetchCategories()
    var products: [Product] {get set}
}

final class MenuViewController: UIViewController, ScreenRoutable {
    
    var presenter: MenuViewOutputProtocol?

    var tableAdapter: MenuTableAdapter
    
    init(tableAdapter: MenuTableAdapter) {
        self.tableAdapter = tableAdapter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - CityLabel
    private let cityLabel = UILabel(text: "Москва")
    private let chevronImageView = UIImageView(image: UIImage(named: "chevron", in: .module, with: nil))
    private lazy var chooseCityView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .clear
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(cityButtonTapped)))
        
        return view
    }()
    
    //MARK: - BannersView
    private lazy var bannerHeaderView: BannersView = {
        let width = UIView.screenWidth
        let height = width * 0.3
        let bannerView = BannersView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        return bannerView
    }()
    
    //MARK: - TableView
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.register(ProductCell.self, forCellReuseIdentifier: ProductCell.reuseID)
        tableView.dataSource = tableAdapter
        tableView.delegate = tableAdapter
        tableView.tableHeaderView = bannerHeaderView
        tableView.separatorStyle = .none
        
        return tableView
    }()

    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.fetchProducts()

        setupViews()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.rowHeight = view.bounds.height / 5
    }
    
    //MARK: - Private Methods
    private func setupViews(){
        view.backgroundColor = .systemBackground
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        view.addSubview(cityLabel)
        cityLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview().offset(16)
        }
        
        view.addSubview(chevronImageView)
        chevronImageView.snp.makeConstraints { make in
            make.centerY.equalTo(cityLabel).offset(1)
            make.leading.equalTo(cityLabel.snp.trailing).offset(8)
            make.size.equalTo(CGSize(width: 14, height: 8))
        }
        
        view.addSubview(chooseCityView)
        chooseCityView.snp.makeConstraints { make in
            make.top.bottom.leading.equalTo(cityLabel)
            make.trailing.equalTo(chevronImageView)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(chooseCityView.snp.bottom).offset(24)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    //MARK: - Actions
    @objc private func cityButtonTapped() {
        let popOverCityVC = CityPopOverAssembly().configure()
        popOverCityVC.modalPresentationStyle = .popover
        popOverCityVC.preferredContentSize = CGSize(width: 200, height: 200)

        guard let presentionVC = popOverCityVC.popoverPresentationController else { return }
        presentionVC.delegate = self
        presentionVC.sourceView = chevronImageView
        presentionVC.permittedArrowDirections = .up
        presentionVC.sourceRect = CGRect(x: chevronImageView.bounds.midX,
                                         y: chevronImageView.bounds.midY, width: 0, height: 0)
        present(popOverCityVC, animated: true)
    }
}

//MARK: - CategoriesViewDelegate
extension MenuViewController: CategoriesViewDelegate {
    func scrollToRow(with category: String) {
        guard let index = presenter?.products.firstIndex(where: {$0.category == category}) else { return }
        tableView.scrollToRow(at: IndexPath(row: index, section: 0) , at: .top, animated: true)
    }
}


//MARK: - UIPopoverPresentationControllerDelegate
extension MenuViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

//MARK: - MenuViewInputProtocol
extension MenuViewController: MenuViewInputProtocol {
    
    func updateProducts(_ products: [Product]) {
        tableAdapter.items = products
        presenter?.fetchCategories()
        tableView.reloadData()
    }
    
    func updateCategories(_ categories: [String]) {
        tableAdapter.categories = categories
        tableView.reloadData()
    }
    
    func updateBanners(_ banners: [String]) {
        self.bannerHeaderView.update(bannersString: banners)
        self.tableView.reloadData()
    }
}


