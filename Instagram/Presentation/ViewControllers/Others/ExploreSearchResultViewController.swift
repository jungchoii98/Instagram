//
//  ExploreSearchResultViewController.swift
//  Instagram
//
//  Created by Jung Choi on 8/22/23.
//

import UIKit

protocol ExploreSearchResultViewControllerDelegate: AnyObject {
    func exploreSearchResultViewControllerDidSelectUser(_ exploreSearchResultViewController: ExploreSearchResultViewController, user: User)
}

class ExploreSearchResultViewController: UIViewController {
    
    enum Section {
        case main
    }
    
    weak var delegate: ExploreSearchResultViewControllerDelegate?
    private let tableView = UITableView()
    private var dataSource: UITableViewDiffableDataSource<Section, User>!
    private var users = [User]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "\(UITableViewCell.self)")
        tableView.delegate = self
        configureDataSource()
    }
    
    private func configureDataSource() {
        dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, itemIdentifier in
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(UITableViewCell.self)", for: indexPath)
            var content = cell.defaultContentConfiguration()
            content.text = itemIdentifier.username
            cell.contentConfiguration = content
            return cell
        })
        update()
    }
    
    private func update() {
        DispatchQueue.main.async {
            var snapshot = NSDiffableDataSourceSnapshot<Section, User>()
            snapshot.appendSections([.main])
            snapshot.appendItems(self.users)
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    func update(with users: [User]) {
        self.users = users
        tableView.isHidden = users.isEmpty
        update()
    }
}

extension ExploreSearchResultViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.exploreSearchResultViewControllerDidSelectUser(self, user: users[indexPath.row])
    }
}
