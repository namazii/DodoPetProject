//
//  CityPopOverViewController.swift
//  test-sfera
//
//  Created by Назар Ткаченко on 27.11.2022.
//

import UIKit
import SnapKit

protocol CityPopOverViewInputProtocol: AnyObject {
    func updateCities(_ cities: [String])
}

protocol CityPopOverViewOutputProtocol {
    func loadView()
}

final class CityPopOverViewController: UIViewController, ScreenRoutable {
    
    var presenter: CityPopOverViewOutputProtocol?
    
    var tableAdapter: CityPopOverTableAdapter
    
    init(tableAdapter: CityPopOverTableAdapter) {
        self.tableAdapter = tableAdapter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private Properties
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.register(CityPopOverCell.self, forCellReuseIdentifier: CityPopOverCell.reuseID)
        tableView.dataSource = tableAdapter
        tableView.delegate = tableAdapter
        tableView.separatorStyle = .none
        
        return tableView
    }()

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.loadView()
        
        setupViews()
        tableView.reloadData()
    }
    
    //MARK: - Private Methods
    private func setupViews() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

//MARK: - CityPopOverViewInputProtocol
extension CityPopOverViewController: CityPopOverViewInputProtocol {
    func updateCities(_ cities: [String]) {
        tableAdapter.cities = cities
    }
}
