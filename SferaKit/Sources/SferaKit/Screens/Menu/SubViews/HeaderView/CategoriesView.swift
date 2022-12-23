//
//  CategoriesView.swift
//  test-sfera
//
//  Created by Назар Ткаченко on 27.11.2022.
//

import UIKit

//MARK: - CategoriesViewDelegate
protocol CategoriesViewDelegate: AnyObject {
    func scrollToRow(with category: String)
}

//MARK: - CategoriesView
final class CategoriesView: UITableViewHeaderFooterView {
    
    weak var delegate: CategoriesViewDelegate?
    
    //MARK: - Private Properties
    private var categories: [String]
    
    private var loaded: Bool
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        
        collectionView.allowsSelection = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.reuseID)
        collectionView.register(CategorySkeletonCell.self, forCellWithReuseIdentifier: CategorySkeletonCell.reuseID)
        collectionView.backgroundColor = .systemBackground
        
        return collectionView
    }()
    
    //MARK: - LifeCycle
    init(categories: [String], loaded: Bool) {
        self.categories = categories
        self.loaded = loaded
        super.init(reuseIdentifier: CategoryCell.reuseID)
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private Properties
    private func setupViews() {
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func createCompositionalLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout(section: createButtonView())
    }
    
    private func createButtonView() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)
        
        let rowHeight = NSCollectionLayoutDimension.fractionalHeight(1)
        let rowSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.26), heightDimension: rowHeight)
        
        let row = NSCollectionLayoutGroup.horizontal(layoutSize: rowSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: row)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 0)
        
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        
        return section
    }
}

//MARK: - UICollectionViewDataSource
extension CategoriesView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if loaded {
            collectionView.allowsSelection = true
            return categories.count
        } else {
            return 4
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if loaded {
            guard let cell: CategoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.reuseID, for: indexPath) as? CategoryCell else { return UICollectionViewCell() }
            cell.configure(category: categories[indexPath.row])
            
            return cell
        } else {
            guard let cell: CategorySkeletonCell = collectionView.dequeueReusableCell(withReuseIdentifier: CategorySkeletonCell.reuseID, for: indexPath) as? CategorySkeletonCell else { return UICollectionViewCell() }
            
            return cell
        }
    }
}

//MARK: - UICollectionViewDelegate
extension CategoriesView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell: CategoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.reuseID, for: indexPath) as! CategoryCell
        cell.isSelected = true
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        delegate?.scrollToRow(with: categories[indexPath.row])
    }
}
