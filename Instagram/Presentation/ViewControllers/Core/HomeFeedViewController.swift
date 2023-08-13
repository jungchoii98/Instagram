//
//  HomeFeedViewController.swift
//  Instagram
//
//  Created by Jung Choi on 7/26/23.
//

import UIKit

protocol HomeFeedViewControllerDelegate: AnyObject {}

class HomeFeedViewController: UIViewController {
    
    enum Section {
        case main
    }
    
    private var collectionView: HomeFeedCollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Int,HomeFeedCellType>!
    
    weak var coordinator: HomeFeedViewControllerDelegate?
    private var viewModel: HomeFeedVCViewModel
    
    init(viewModel: HomeFeedVCViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        view.backgroundColor = .systemBackground
        configureCollectionView()
        viewModel.fetchPosts()
    }
    
    private func configureCollectionView() {
        collectionView = HomeFeedCollectionView(frame: .zero, collectionViewLayout: HomeFeedCollectionView.collectionViewLayout(viewWidth: view.width))
        view.addSubview(collectionView)
        configureDataSource()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
            cell.backgroundColor = .blue
            cell.layer.borderColor = UIColor.black.cgColor
            cell.layer.borderWidth = 1.0
            return cell
        })
        update()
    }
    
    private func update() {
        DispatchQueue.main.async {
            var snapshot = NSDiffableDataSourceSnapshot<Int,HomeFeedCellType>()
            for (index, item) in self.viewModel.posts.enumerated() {
                snapshot.appendSections([index])
                snapshot.appendItems(item, toSection: index)
            }
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
}
