//
//  ExploreViewController.swift
//  Instagram
//
//  Created by Jung Choi on 7/26/23.
//

import UIKit

protocol ExploreViewControllerDelegate: AnyObject {
    func exploreViewControllerDidSelectUser(_ exploreViewController: ExploreViewController, user: User)
}

class ExploreViewController: UIViewController {
    
    private let searchResultVC = ExploreSearchResultViewController()
    private let searchController = UISearchController()
    private var searchControllerWorkItem: DispatchWorkItem!
    
    weak var coordinator: ExploreViewControllerDelegate?
    private let viewModel: ExploreViewModel
    
    init(viewModel: ExploreViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        title = "Explore"
        view.backgroundColor = .systemBackground
        navigationItem.searchController = searchController
        searchResultVC.delegate = self
        
        view.addSubview(searchResultVC.view)
        searchResultVC.view.translatesAutoresizingMaskIntoConstraints = false
        searchResultVC.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        searchResultVC.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        searchResultVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        searchResultVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        addChild(searchResultVC)
        
        setUpSearchController()
    }
}

private extension ExploreViewController {
    func setUpSearchController() {
        searchController.searchResultsUpdater = self
    }
}

extension ExploreViewController: ExploreViewModelDelegate {
    func exploreViewModelSearchCompleted(_ exploreViewModel: ExploreViewModel, _ users: [User]) {
        searchResultVC.update(with: users)
    }
}

extension ExploreViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        searchControllerWorkItem?.cancel()
        searchControllerWorkItem = DispatchWorkItem() { [weak self] in
            self?.viewModel.searchForUsers(with: query)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75, execute: searchControllerWorkItem)
    }
}

extension ExploreViewController: ExploreSearchResultViewControllerDelegate {
    func exploreSearchResultViewControllerDidSelectUser(_ exploreSearchResultViewController: ExploreSearchResultViewController, user: User) {
        coordinator?.exploreViewControllerDidSelectUser(self, user: user)
    }
}
