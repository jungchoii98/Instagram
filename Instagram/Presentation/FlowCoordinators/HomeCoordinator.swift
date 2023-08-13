//
//  HomeCoordinator.swift
//  Instagram
//
//  Created by Jung Choi on 7/26/23.
//

import UIKit

final class HomeCoordinator: Coordinator {
    
    private let navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showHome()
    }
    
    private func showHome() {
        let viewModel = HomeFeedVCViewModel()
        let homeVC = HomeFeedViewController(viewModel: viewModel)
        homeVC.coordinator = self
        navigationController.pushViewController(homeVC, animated: true)
    }
}

extension HomeCoordinator: HomeFeedViewControllerDelegate {}
