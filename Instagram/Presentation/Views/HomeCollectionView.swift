//
//  HomeCollectionView.swift
//  Instagram
//
//  Created by Jung Choi on 8/13/23.
//

import UIKit

final class HomeCollectionView: UICollectionView {
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        configureCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCollectionView() {
        register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        
        backgroundColor = .systemBackground
    }
    
    static func collectionViewLayout(viewWidth: CGFloat) -> UICollectionViewLayout {
        let postHeight: CGFloat = 60
        let posterHeight: CGFloat = viewWidth
        let actionsHeight: CGFloat = 40
        let likesHeight: CGFloat = 40
        let captionHeight: CGFloat = 60
        let timestampHeight: CGFloat = 40
        
        let groupHeight = postHeight + posterHeight + actionsHeight + likesHeight + captionHeight + timestampHeight
        
        let postSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(postHeight))
        let postItem = NSCollectionLayoutItem(layoutSize: postSize)
        
        let posterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(posterHeight))
        let posterItem = NSCollectionLayoutItem(layoutSize: posterSize)
        
        let actionsSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(actionsHeight))
        let actionsItem = NSCollectionLayoutItem(layoutSize: actionsSize)
        
        let likesSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(likesHeight))
        let likesItem = NSCollectionLayoutItem(layoutSize: likesSize)
        
        let captionSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(captionHeight))
        let captionItem = NSCollectionLayoutItem(layoutSize: captionSize)
        
        let timestampSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(timestampHeight))
        let timestampItem = NSCollectionLayoutItem(layoutSize: timestampSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(groupHeight))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [postItem, posterItem, actionsItem, likesItem, captionItem, timestampItem])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 0, bottom: 10, trailing: 0)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
}
