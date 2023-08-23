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
    private let posts = [Post]()
    
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
            snapshot.appendItems([
                Post(username: "", avatarImageURL: "", postImageURL: "https://www.allprodad.com/wp-content/uploads/2021/03/05-12-21-happy-people.jpg", likers: [], caption: "", timestamp: ""),
                Post(username: "", avatarImageURL: "", postImageURL: "https://images.unsplash.com/photo-1636246441747-7d7f83f4629c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8MXx8fGVufDB8fHx8fA%3D%3D&w=1000&q=80", likers: [], caption: "", timestamp: ""),
                Post(username: "", avatarImageURL: "", postImageURL: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ8CldTqNpzN9ENCGC79zNXg6EfcqEHXTLjQg&usqp=CAU", likers: [], caption: "", timestamp: ""),
                Post(username: "", avatarImageURL: "", postImageURL: "https://img.freepik.com/free-photo/wide-angle-shot-single-tree-growing-clouded-sky-during-sunset-surrounded-by-grass_181624-22807.jpg?w=2000", likers: [], caption: "", timestamp: ""),
                Post(username: "", avatarImageURL: "", postImageURL: "https://www.alleycat.org/wp-content/uploads/2019/03/FELV-cat.jpg", likers: [], caption: "", timestamp: ""),
                Post(username: "", avatarImageURL: "", postImageURL: "https://cdn.britannica.com/39/7139-050-A88818BB/Himalayan-chocolate-point.jpg", likers: [], caption: "", timestamp: ""),
                
            ])
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
}
