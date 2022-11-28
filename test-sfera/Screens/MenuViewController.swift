//
//  MenuViewController.swift
//  test-sfera
//
//  Created by Назар Ткаченко on 27.11.2022.
//

import UIKit
import SnapKit

protocol MenuViewInputProtocol: AnyObject {
    func updateProducts(_ banners: [String])
}

protocol MenuViewOutputProtocol {
    init(view: MenuViewInputProtocol)
    func loadView()
    func didTapShowProductDetailCell(_ product: Product)
    func didTapCity()
    func fetchCategories() -> [String]
    
    var products: [Product] {get set}
   
}

class MenuViewController: UIViewController, ScreenRoutable {
    
    //MARK: - Private Properties
    private let assembly: MenuAssemblyInputProtocol = MenuAssembly()
    
    //MARK: - CityLabel
    private let cityLabel = UILabel(text: "Москва")
    private let chevronImageView = UIImageView(image: UIImage(named: "chevron"))
    private lazy var chooseCityView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .clear
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapCity)))
        
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
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.register(ProductCell.self, forCellReuseIdentifier: ProductCell.reuseID)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableHeaderView = bannerHeaderView
        tableView.separatorStyle = .none
        
        return tableView
    }()
    
    //MARK: - Properties
    var presenter: MenuViewOutputProtocol?
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        assembly.configure(withView: self)
        
        presenter?.loadView()

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
    @objc private func didTapCity() {
        
        //presenter?.didTapCity()
        
        //presenter.router?.showCities(imageView: chevronImageView)
        
        let popOverCityVC = CityPopOverViewController()
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

//MARK: - UIPopoverPresentationControllerDelegate
extension MenuViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        .none
    }
}

//MARK: - MenuViewInputProtocol
extension MenuViewController: MenuViewInputProtocol {
    func updateProducts(_ banners: [String]) {
        self.bannerHeaderView.update(bannersString: banners)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

//MARK: - DataSource, Delegate
extension MenuViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let product = presenter?.products[indexPath.row] else { return }
        presenter?.didTapShowProductDetailCell(product)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let categories = presenter?.fetchCategories()
        let categoriesView = CategoriesView(categories: categories ?? [])
        categoriesView .delegate = self
        
        return categoriesView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.products.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductCell.reuseID, for: indexPath) as? ProductCell else { return UITableViewCell() }
        if let products = presenter?.products[indexPath.row] {
            cell.configure(model: products)
        }
        
        return cell
    }
}

//MARK: - ScrollToCategoryViewDelegate
extension MenuViewController: ScrollToCategoryViewDelegate {
    func scrollToRow(with category: String) {
        guard let index = presenter?.products.firstIndex(where: {$0.category == category}) else { return }
        tableView.scrollToRow(at: IndexPath(row: index, section: 0) , at: .top, animated: true)
    }
}
