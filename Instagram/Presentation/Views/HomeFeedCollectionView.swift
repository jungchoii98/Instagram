//
//  HomeFeedCollectionView.swift
//  Instagram
//
//  Created by Jung Choi on 8/13/23.
//

import UIKit

final class HomeFeedCollectionView: UICollectionView {
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        configureCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCollectionView() {
        register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        register(PosterCollectionViewCell.self, forCellWithReuseIdentifier: PosterCollectionViewCell.reuseID)
        register(PostCollectionViewCell.self, forCellWithReuseIdentifier: PostCollectionViewCell.reuseID)
        register(ActionsCollectionViewCell.self, forCellWithReuseIdentifier: ActionsCollectionViewCell.reuseID)
        register(LikesCountCollectionViewCell.self, forCellWithReuseIdentifier: LikesCountCollectionViewCell.reuseID)
        
        backgroundColor = .systemBackground
    }
    
    static func collectionViewLayout(viewWidth: CGFloat) -> UICollectionViewLayout {
        let posterHeight: CGFloat = 60
        let postHeight: CGFloat = viewWidth
        let actionsHeight: CGFloat = 40
        let likesCountHeight: CGFloat = 40
        let captionHeight: CGFloat = 60
        let timestampHeight: CGFloat = 40
        
        let groupHeight = postHeight + posterHeight + actionsHeight + likesCountHeight + captionHeight + timestampHeight
        
        let posterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(posterHeight))
        let posterItem = NSCollectionLayoutItem(layoutSize: posterSize)
        
        let postSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(postHeight))
        let postItem = NSCollectionLayoutItem(layoutSize: postSize)
        
        let actionsSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(actionsHeight))
        let actionsItem = NSCollectionLayoutItem(layoutSize: actionsSize)
        
        let likesCountSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(likesCountHeight))
        let likesCountItem = NSCollectionLayoutItem(layoutSize: likesCountSize)
        
        let captionSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(captionHeight))
        let captionItem = NSCollectionLayoutItem(layoutSize: captionSize)
        
        let timestampSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(timestampHeight))
        let timestampItem = NSCollectionLayoutItem(layoutSize: timestampSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(groupHeight))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [posterItem, postItem, actionsItem, likesCountItem, captionItem, timestampItem])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 0, bottom: 10, trailing: 0)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
}
