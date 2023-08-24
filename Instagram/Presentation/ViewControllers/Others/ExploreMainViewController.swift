//
//  ExploreMainViewController.swift
//  Instagram
//
//  Created by Jung Choi on 8/23/23.
//

import UIKit

class ExploreMainViewController: UIViewController {
    
    enum Section {
        case main
    }
    
    var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section,Post>!
    private var posts = [Post]()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        collectionView = ExplorePostCollectionView(frame: view.bounds, collectionViewLayout: ExplorePostCollectionView.configureLayout())
        view.addSubview(collectionView)
        configureDataSource()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExplorePostCollectionViewCell.reuseID, for: indexPath) as! ExplorePostCollectionViewCell
            cell.configure(with: itemIdentifier.postImageURL)
            return cell
        })
        update()
    }
    
    private func update() {
        DispatchQueue.main.async {
            var snapshot = NSDiffableDataSourceSnapshot<Section,Post>()
            snapshot.appendSections([.main])
            snapshot.appendItems(self.posts)
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    func update(with posts: [Post]) {
        self.posts = posts
        update()
    }
}
