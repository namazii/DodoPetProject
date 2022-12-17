//
//  CityPopOverTableAdapter.swift
//  
//
//  Created by Назар Ткаченко on 17.12.2022.
//

import UIKit

final class CityPopOverTableAdapter: NSObject {
    var cities: [String] = []
}

extension CityPopOverTableAdapter: UITableViewDelegate {
}

extension CityPopOverTableAdapter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CityPopOverCell.reuseID, for: indexPath) as? CityPopOverCell else { return UITableViewCell() }
        cell.configure(city: cities[indexPath.row])
        return cell
    }
}
