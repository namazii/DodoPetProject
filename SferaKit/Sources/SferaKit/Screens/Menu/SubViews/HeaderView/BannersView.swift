//
//  BannersView.swift
//  test-sfera
//
//  Created by Назар Ткаченко on 27.11.2022.
//

import UIKit
import SnapKit

final class BannersView: UIView {
    
    //MARK: - Private Properties
    private var banners = [String]()
    
    private var loaded = false
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        
        collectionView.allowsSelection = false
        collectionView.dataSource = self
        collectionView.register(BannersCell.self, forCellWithReuseIdentifier: BannersCell.reuseID)
        collectionView.register(BannersSkeletonCell.self, forCellWithReuseIdentifier: BannersSkeletonCell.reuseID)
        collectionView.backgroundColor = .systemBackground
        
        return collectionView
    }()

    //MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public Methods
    func update(bannersString: [String]) {
        banners = bannersString
        loaded = true
        collectionView.reloadData()
    }
    
    //MARK: - Private Properties
    private func setupViews() {
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func createCompositionalLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout(section: createPromotionsView())
    }
    
    private func createPromotionsView()  -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 16)
        
        let rowHeight = NSCollectionLayoutDimension.fractionalHeight(1)
        let rowSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8),
                                             heightDimension: rowHeight)
        let row = NSCollectionLayoutGroup.horizontal(layoutSize: rowSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: row)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0)
        
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        
        return section
    }
}

//MARK: - DataSource
extension BannersView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if loaded {
            return banners.count
        } else {
            return 3
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if loaded {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannersCell.reuseID, for: indexPath) as? BannersCell else { return UICollectionViewCell()}
            
            let banner = banners[indexPath.row]
            cell.configure(string: banner)
            
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannersSkeletonCell.reuseID, for: indexPath) as? BannersSkeletonCell else { return  UICollectionViewCell() }
            
            return cell
        }
    }
}
