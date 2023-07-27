//
//  HomeCoordinator.swift
//  Instagram
//
//  Created by Jung Choi on 7/26/23.
//

import UIKit

final class HomeCoordinator: Coordinator {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showHome()
    }
    
    private func showHome() {
        let homeVC = HomeViewController()
        homeVC.delegate = self
        navigationController.pushViewController(homeVC, animated: true)
    }
}

extension HomeCoordinator: HomeViewControllerDelegate {}
