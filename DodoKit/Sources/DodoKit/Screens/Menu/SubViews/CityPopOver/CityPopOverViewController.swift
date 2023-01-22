//
//  CityPopOverViewController.swift
//  DodoPetProject
//
//  Created by Назар Ткаченко on 27.11.2022.
//

import UIKit
import SnapKit

protocol CityPopOverViewOutputProtocol: AnyObject {
    func selectedСity(_ string: String)
}

final class CityPopOverViewController: UIViewController {
    
    weak var delegate: CityPopOverViewOutputProtocol?
    
    private var cities = ["Москва", "Санкт-Петербург", "Новосибирск", "Екатеринбург", "Казань", "Самара", "Омск"]
    
    //MARK: - Private Properties
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.register(CityPopOverCell.self, forCellReuseIdentifier: CityPopOverCell.reuseID)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        
        return tableView
    }()

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        addSubviews()
        setupConstraints()
    }
    
    //MARK: - Private Methods
    private func setupView() {
        view.backgroundColor = .systemBackground
    }
    
    private func addSubviews() {
        view.addSubview(tableView)
    }
}

//MARK: - SetupConstraints
extension CityPopOverViewController {
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

//MARK: - UITableViewDelegate
extension CityPopOverViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.selectedСity(cities[indexPath.row])
        presentingViewController?.dismiss(animated: true)
    }
}

//MARK: - UITableViewDataSource
extension CityPopOverViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CityPopOverCell.reuseID, for: indexPath) as? CityPopOverCell else { return UITableViewCell() }
        cell.configure(city: cities[indexPath.row])
        return cell
    }
}
