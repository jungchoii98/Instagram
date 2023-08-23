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
        viewModel.delegate = self
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

private extension HomeFeedViewController {
    func displayShareOptions() {
        let activityViewController = UIActivityViewController(activityItems: [], applicationActivities: nil)
        navigationController?.present(activityViewController, animated: true)
    }
    
    func displayMoreOptions() {
        let alertViewController = UIAlertController(title: "More Options", message: "Please select an option", preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let shareAction = UIAlertAction(title: "Share", style: .default) { action in
        }
        let reportAction = UIAlertAction(title: "Report", style: .destructive) { action in
        }
        alertViewController.addAction(cancelAction)
        alertViewController.addAction(shareAction)
        alertViewController.addAction(reportAction)
        navigationController?.present(alertViewController, animated: true)
    }
}

extension HomeFeedViewController: HomeFeedVCViewModelDelegate {
    func homeFeedVCViewModelDidFetchPosts(_ homeFeedVCViewModel: HomeFeedVCViewModel) {
        update()
    }
}

extension HomeFeedViewController: PosterCollectionViewCellDelegate {
    func posterCollectionViewCellDidTapUsername(_ cell: PosterCollectionViewCell, with username: String) {
        print("username tapped: \(username)")
    }
    
    func posterCollectionViewCellDidTapMore(_ cell: PosterCollectionViewCell) {
        displayMoreOptions()
    }
}

extension HomeFeedViewController: PostCollectionViewCellDelegate {
    func postCollectionViewCellDidDoubleTap(_ cell: PostCollectionViewCell) {
        print("double tap liked")
    }
}

extension HomeFeedViewController: ActionsCollectionViewCellDelegate {
    func actionsCollectionViewCellDidTapLike(_ cell: ActionsCollectionViewCell, isLiked: Bool) {
        print("like action tap")
    }
    
    func actionsCollectionViewCellDidTapComment(_ cell: ActionsCollectionViewCell) {
        print("comment action tap")
    }
    
    func actionsCollectionViewCellDidTapShare(_ cell: ActionsCollectionViewCell) {
        displayShareOptions()
    }
}

extension HomeFeedViewController: LikesCountCollectionViewCellDelegate {
    func likesCountCollectionViewCellDidTapCount(_ cell: LikesCountCollectionViewCell) {
        print("likes count tap")
    }
}

extension HomeFeedViewController: CaptionCollectionViewCellDelegate {
    func captionCollectionViewCellDidTapCaption(_ cell: CaptionCollectionViewCell) {
        print("caption tap")
    }
}

private extension HomeFeedViewController {
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            switch itemIdentifier {
            case .poster(let viewModel):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.reuseID, for: indexPath) as! PosterCollectionViewCell
                cell.delegate = self
                cell.configure(with: viewModel)
                return cell
            case .post(let viewModel):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostCollectionViewCell.reuseID, for: indexPath) as! PostCollectionViewCell
                cell.delegate = self
                cell.configure(with: viewModel)
                return cell
            case .actions(let viewModel):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ActionsCollectionViewCell.reuseID, for: indexPath) as! ActionsCollectionViewCell
                cell.delegate = self
                cell.configure(with: viewModel)
                return cell
            case .likesCount(let viewModel):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LikesCountCollectionViewCell.reuseID, for: indexPath) as! LikesCountCollectionViewCell
                cell.delegate = self
                cell.configure(with: viewModel)
                return cell
            case .caption(let viewModel):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CaptionCollectionViewCell.reuseID, for: indexPath) as! CaptionCollectionViewCell
                cell.delegate = self
                cell.configure(with: viewModel)
                return cell
            case .timestamp(let viewModel):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TimestampCollectionViewCell.reuseID, for: indexPath) as! TimestampCollectionViewCell
                cell.configure(with: viewModel)
                return cell
            }
        })
        update()
    }
}
