//
//  DetailProductTableAdapter.swift
//  
//
//  Created by Назар Ткаченко on 17.12.2022.
//

import UIKit

final class DetailProductTableAdapter: NSObject {
    
    var product: Product?
    
    enum SectionType: Int, CaseIterable {
        case image = 0
        case info = 1
    }
    
}

extension DetailProductTableAdapter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SectionType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let sectionType = SectionType.init(rawValue: indexPath.row)
        
        switch sectionType {
        case .image:
            return UIScreen.main.bounds.height / 2
            
        case .info:
            return UIScreen.main.bounds.height / 10
            
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
            
            cell.configure(image: product?.image ?? "pizza")
            return cell
        case .info:
            let infoCell = tableView.dequeueReusableCell(withIdentifier: ProductInfoCell.reuseID)
            guard let cell = infoCell as? ProductInfoCell else { return UITableViewCell() }
            
            cell.configure(product: product)
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension DetailProductTableAdapter: UITableViewDelegate {
}
