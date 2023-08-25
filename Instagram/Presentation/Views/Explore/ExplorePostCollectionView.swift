//
//  ExplorePostCollectionView.swift
//  Instagram
//
//  Created by Jung Choi on 8/23/23.
//

import UIKit

class ExplorePostCollectionView: UICollectionView {

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        register(ExplorePostCollectionViewCell.self, forCellWithReuseIdentifier: ExplorePostCollectionViewCell.reuseID)
        backgroundColor = .systemBackground
    }
    
    static func configureLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let halfItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5))
        let halfItem = NSCollectionLayoutItem(layoutSize: halfItemSize)
        
        let tripletItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.33), heightDimension: .fractionalHeight(1))
        let tripletItem = NSCollectionLayoutItem(layoutSize: tripletItemSize)
        
        let leftGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .absolute(160))
        let leftGroup = NSCollectionLayoutGroup.vertical(layoutSize: leftGroupSize, subitems: [item])
        
        let rightGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .absolute(160))
        var rightGroup: NSCollectionLayoutGroup!
        if #available(iOS 16.0, *) {
            rightGroup = NSCollectionLayoutGroup.vertical(layoutSize: rightGroupSize, repeatingSubitem: halfItem, count: 2)
        } else {
            rightGroup = NSCollectionLayoutGroup.vertical(layoutSize: rightGroupSize, subitem: halfItem, count: 2)
        }
        
        let topGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(160))
        let topGroup = NSCollectionLayoutGroup.horizontal(layoutSize: topGroupSize, subitems: [leftGroup, rightGroup])
        
        let bottomGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(160))
        var bottomGroup: NSCollectionLayoutGroup!
        if #available(iOS 16.0, *) {
            bottomGroup = NSCollectionLayoutGroup.horizontal(layoutSize: bottomGroupSize, repeatingSubitem: tripletItem, count: 3)
        } else {
            bottomGroup = NSCollectionLayoutGroup.horizontal(layoutSize: bottomGroupSize, subitem: tripletItem, count: 3)
        }
        
        let fullGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(320))
        let fullGroup = NSCollectionLayoutGroup.vertical(layoutSize: fullGroupSize, subitems: [topGroup,bottomGroup])
        
        let section = NSCollectionLayoutSection(group: fullGroup)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
}
