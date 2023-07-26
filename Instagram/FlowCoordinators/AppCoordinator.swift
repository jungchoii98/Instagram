//
//  AppCoordinator.swift
//  Instagram
//
//  Created by Jung Choi on 7/26/23.
//

import UIKit

protocol Coordinator {
    func start()
}

class AppCoordinator {
    
    let tabBarController: UITabBarController
    
    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
        setUp()
    }
    
    func setUp() {
        let homeNavigationController = UINavigationController()
        let exploreNavigationController = UINavigationController()
        let cameraNavigationController = UINavigationController()
        let notificationsNavigationController = UINavigationController()
        let profileNavigationController = UINavigationController()
        
        let homeFlowCoordinator = HomeCoordinator(navigationController: homeNavigationController)
        let exploreFlowCoordinator = ExploreCoordinator(navigationController: exploreNavigationController)
        let cameraFlowCoordinator = CameraCoordinator(navigationController: cameraNavigationController)
        let notificationsFlowCoordinator = NotificationsCoordinator(navigationController: notificationsNavigationController)
        let profileFlowCoordinator = ProfileCoordinator(navigationController: profileNavigationController)
        homeFlowCoordinator.start()
        exploreFlowCoordinator.start()
        cameraFlowCoordinator.start()
        notificationsFlowCoordinator.start()
        profileFlowCoordinator.start()
        
        tabBarController.setViewControllers([
            homeNavigationController,
            exploreNavigationController,
            cameraNavigationController,
            notificationsNavigationController,
            profileNavigationController
        ],
            animated: false
        )
    }
    
    func start() {
        
    }
}
