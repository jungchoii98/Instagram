//
//  SettingsViewController.swift
//  Instagram
//
//  Created by Jung Choi on 7/26/23.
//

import UIKit

protocol SettingsViewControllerDelegate: AnyObject {
    func didTapSignOut()
}

class SettingsViewController: UIViewController {
    
    enum Section {
        case main
    }
    
    private let signOutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Out", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        return button
    }()
    
    private let tableView: UITableView = UITableView()
    private var dataSource: UITableViewDiffableDataSource<Section, Int>!
    
    weak var coordinator: SettingsViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Settings"
        view.backgroundColor = .systemBackground
        configureTableView()
        configureSignOutButton()
    }
    
    override func viewWillLayoutSubviews() {
        signOutButton.frame = CGRect(x: 0, y: 0, width: view.width, height: 50)
    }
    
    private func configureSignOutButton() {
        signOutButton.addTarget(self, action: #selector(didTapSignOutButton), for: .touchUpInside)
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.tableFooterView = signOutButton
    }
    
    private func configureDataSource() {
        dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, itemIdentifier in
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(UITableViewCell.self)", for: indexPath)
            cell.textLabel?.text = "\(itemIdentifier)"
            return cell
        })
        DispatchQueue.main.async {
            var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
            snapshot.appendSections([.main])
            snapshot.appendItems([1,2])
            self.dataSource.apply(snapshot, animatingDifferences: false)
        }
    }
    
    // MARK: Actions
    
    @objc func didTapSignOutButton() {
        let alertController = UIAlertController(title: "Sign Out", message: "Are You Sure?", preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let signOutAction = UIAlertAction(title: "Sign Out", style: .destructive) { _ in 
            AuthManager.shared.signOut { [weak self] signOutDidSucceed in
                guard let self = self else { return }
                if signOutDidSucceed {
                    self.coordinator?.didTapSignOut()
                } else {
                    print("error signing out")
                }
            }
        }
        alertController.addAction(cancelAction)
        alertController.addAction(signOutAction)
        present(alertController, animated: true)
    }
}
