//
//  HomeCoordinator.swift
//  Instagram
//
//  Created by Jung Choi on 7/26/23.
//

import UIKit

class HomeCoordinator: Coordinator {
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showHome()
    }
    
    func showHome() {
        let homeVC = HomeViewController()
        homeVC.delegate = self
        navigationController.pushViewController(homeVC, animated: false)
    }
}

extension HomeCoordinator: HomeViewControllerDelegate {}
