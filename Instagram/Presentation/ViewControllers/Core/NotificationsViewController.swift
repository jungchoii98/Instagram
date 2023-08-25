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
        case main
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
    private var dataSource: UITableViewDiffableDataSource<Section,NotificationCellType>!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Notifications"
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        view.addSubview(noActivityLabel)
        tableView.delegate = self
        configureDatasouce()
        noActivityLabel.isHidden = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        noActivityLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        noActivityLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        noActivityLabel.sizeToFit()
    }
    
    private func configureDatasouce() {
        dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, itemIdentifier in
            switch itemIdentifier {
            case .likes:
                let cell = tableView.dequeueReusableCell(withIdentifier: LikesNotificationTableViewCell.reuseID, for: indexPath) as! LikesNotificationTableViewCell
                return cell
            case .follow:
                let cell = tableView.dequeueReusableCell(withIdentifier: FollowNotificationTableViewCell.reuseID, for: indexPath) as! FollowNotificationTableViewCell
                return cell
            case .comment:
                let cell = tableView.dequeueReusableCell(withIdentifier: CommentNotificationTableViewCell.reuseID, for: indexPath) as! CommentNotificationTableViewCell
                return cell
            }
        })
    }
}

extension NotificationsViewController: UITableViewDelegate {
    
}
