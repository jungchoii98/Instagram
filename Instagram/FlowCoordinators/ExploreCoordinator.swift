//
//  ExploreCoordinator.swift
//  Instagram
//
//  Created by Jung Choi on 7/26/23.
//

import UIKit

class ExploreCoordinator: Coordinator {
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showExplore()
    }
    
    func showExplore() {
        let exploreVC = ExploreViewController()
        exploreVC.delegate = self
        navigationController.pushViewController(exploreVC, animated: false)
    }
}

extension ExploreCoordinator: ExploreViewControllerDelegate {}
