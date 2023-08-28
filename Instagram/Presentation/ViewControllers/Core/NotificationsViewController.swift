//
//  NotificationsViewController.swift
//  Instagram
//
//  Created by Jung Choi on 7/26/23.
//

import UIKit

protocol NotificationsViewControllerDelegate: AnyObject {}

class NotificationsViewController: UIViewController {
    
    enum Section {
        case thisWeek
        case thisMonth
        case earlier
    }
    
    private let noActivityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "No Notifications"
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        label.isHidden = true
        return label
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(LikesNotificationTableViewCell.self, forCellReuseIdentifier: LikesNotificationTableViewCell.reuseID)
        tableView.register(FollowNotificationTableViewCell.self, forCellReuseIdentifier: FollowNotificationTableViewCell.reuseID)
        tableView.register(CommentNotificationTableViewCell.self, forCellReuseIdentifier: CommentNotificationTableViewCell.reuseID)
        tableView.isHidden = true
        return tableView
    }()
    
    weak var coordinator: NotificationsViewControllerDelegate?
    private var dataSource: NotificationsTableViewDiffableDataSource<Section,NotificationCellType>!
    private let viewModel: NotificationViewModel
    
    init(viewModel: NotificationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Notifications"
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        view.addSubview(noActivityLabel)
        tableView.delegate = self
        tableView.rowHeight = view.bounds.height/14
        configureDatasouce()
        viewModel.fetchNotifications()
        tableView.isHidden = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        noActivityLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        noActivityLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        noActivityLabel.sizeToFit()
    }
    
    private func configureDatasouce() {
        dataSource = NotificationsTableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, itemIdentifier in
            switch itemIdentifier {
            case .likes(let viewModel):
                let cell = tableView.dequeueReusableCell(withIdentifier: LikesNotificationTableViewCell.reuseID, for: indexPath) as! LikesNotificationTableViewCell
                cell.delegate = self
                cell.configure(with: viewModel)
                return cell
            case .follow(let viewModel):
                let cell = tableView.dequeueReusableCell(withIdentifier: FollowNotificationTableViewCell.reuseID, for: indexPath) as! FollowNotificationTableViewCell
                cell.delegate = self
                cell.configure(with: viewModel)
                return cell
            case .comment(let viewModel):
                let cell = tableView.dequeueReusableCell(withIdentifier: CommentNotificationTableViewCell.reuseID, for: indexPath) as! CommentNotificationTableViewCell
                cell.delegate = self
                cell.configure(with: viewModel)
                return cell
            }
        })
        update()
    }
    
    private func update() {
        DispatchQueue.main.async {
            var snapshot = NSDiffableDataSourceSnapshot<Section, NotificationCellType>()
            snapshot.appendSections([.thisWeek, .thisMonth, .earlier])
            snapshot.appendItems(self.viewModel.thisWeekViewModelCells, toSection: .thisWeek)
            snapshot.appendItems(self.viewModel.thisMonthViewModelCells, toSection: .thisMonth)
            snapshot.appendItems(self.viewModel.earlierViewModelCells, toSection: .earlier)
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
}

extension NotificationsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension NotificationsViewController: NotificationViewModelDelegate {
    func notificationViewModelDidFetchNotifications(_ notificationViewModel: NotificationViewModel) {
        update()
    }
}

extension NotificationsViewController: LikesNotificationTableViewCellDelegate, CommentNotificationTableViewCellDelegate, FollowNotificationTableViewCellDelegate {
    func likesNotificationTableViewCell(_ likesNotificationTableViewCell: LikesNotificationTableViewCell, didTapPost viewModel: LikesNotificationCellViewModel) {
        print("tap post")
    }
    
    func commentNotificationTableViewCell(_ commentNotificationTableViewCell: CommentNotificationTableViewCell, didTapPost viewModel: CommentNotificationCellViewModel) {
        print("tap post")
    }
    
    func followNotificationTableViewCell(_ followNotificationTableViewCell: FollowNotificationTableViewCell, didTapFollow viewModel: FollowNotificationCellViewModel) {
        print("tap follow")
    }
}
