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
    private let exploreMainVC = ExploreMainViewController()
    
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
        
//        view.addSubview(searchResultVC.view)
//        searchResultVC.view.frame = view.bounds
//        addChild(searchResultVC)
//        searchResultVC.didMove(toParent: self)
        setUpSearchController()
        add(searchResultVC)
        
//        view.addSubview(exploreMainVC.view)
//        exploreMainVC.view.frame = view.bounds
//        addChild(exploreMainVC)
//        exploreMainVC.didMove(toParent: self)
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
            searchResultVC.remove()
            add(exploreMainVC)
            return
        }
        searchControllerWorkItem?.cancel()
        searchControllerWorkItem = DispatchWorkItem() { [weak self] in
            guard let self = self else { return }
            self.exploreMainVC.remove()
            self.add(self.searchResultVC)
            self.viewModel.searchForUsers(with: query)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75, execute: searchControllerWorkItem)
    }
}

extension ExploreViewController: ExploreSearchResultViewControllerDelegate {
    func exploreSearchResultViewControllerDidSelectUser(_ exploreSearchResultViewController: ExploreSearchResultViewController, user: User) {
        coordinator?.exploreViewControllerDidSelectUser(self, user: user)
    }
}
