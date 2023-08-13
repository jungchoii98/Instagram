//
//  HomeViewController.swift
//  Instagram
//
//  Created by Jung Choi on 7/26/23.
//

import UIKit

protocol HomeViewControllerDelegate: AnyObject {}

class HomeViewController: UIViewController {
    
    enum Section {
        case main
    }
    
    private var collectionView: HomeCollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section,Int>!
    
    weak var coordinator: HomeViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        view.backgroundColor = .systemBackground
        configureCollectionView()
    }
    
    private func configureCollectionView() {
        collectionView = HomeCollectionView(frame: .zero, collectionViewLayout: HomeCollectionView.collectionViewLayout(viewWidth: view.width))
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
            var snapshot = NSDiffableDataSourceSnapshot<Section,Int>()
            snapshot.appendSections([.main])
            snapshot.appendItems([1,2,3,4,5,6,7,8,9])
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
}
