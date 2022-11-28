//
//  CityPopOverViewController.swift
//  test-sfera
//
//  Created by Назар Ткаченко on 27.11.2022.
//

import UIKit
import SnapKit

protocol CityPopOverViewInputProtocol: AnyObject {
    
}

protocol CityPopOverViewOutputProtocol {
    init(view: CityPopOverViewInputProtocol)
    func loadView()
    var cities: [String] {get set}
}

class CityPopOverViewController: UIViewController {
    
    //MARK: - Private Properties
    private let assembly: CityPopOverAssemblyInputProtocol = CityPopOverAssembly()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.register(CityPopOverCell.self, forCellReuseIdentifier: CityPopOverCell.reuseID)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        
        return tableView
    }()

    //MARK: - Public Properties
    var presenter: CityPopOverViewOutputProtocol?
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        assembly.configure(withView: self)
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
    
}

//MARK: - Delegate, DataSource
extension CityPopOverViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.cities.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CityPopOverCell.reuseID, for: indexPath) as? CityPopOverCell else { return UITableViewCell() }
        guard let cities = presenter?.cities else { return CityPopOverCell() }
        cell.configure(city: cities[indexPath.row])
        return cell
    }
}
