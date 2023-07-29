//
//  ExploreCoordinator.swift
//  Instagram
//
//  Created by Jung Choi on 7/26/23.
//

import UIKit

final class ExploreCoordinator: Coordinator {
    
    private let navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showExplore()
    }
    
    private func showExplore() {
        let exploreVC = ExploreViewController()
        exploreVC.coordinator = self
        navigationController.pushViewController(exploreVC, animated: true)
    }
}

extension ExploreCoordinator: ExploreViewControllerDelegate {}
