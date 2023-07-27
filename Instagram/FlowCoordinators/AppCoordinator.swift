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

final class AppCoordinator {
    
    private var mainTabBarController: UITabBarController?
    private var signInNavigationController: UINavigationController?
    
    private var childCoordinators: [Coordinator] = []
    
    init(mainTabBarController: UITabBarController) {
        self.mainTabBarController = mainTabBarController
    }
    
    init(signInNavigationController: UINavigationController) {
        self.signInNavigationController = signInNavigationController
    }
    
    func start() {
        if mainTabBarController != nil {
            showMainScreen()
        } else {
            showSignIn()
        }
    }
    
    private func showMainScreen() {
        let homeNavigationController = UINavigationController()
        let exploreNavigationController = UINavigationController()
        let cameraNavigationController = UINavigationController()
        let notificationsNavigationController = UINavigationController()
        let profileNavigationController = UINavigationController()
        
        homeNavigationController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 1)
        exploreNavigationController.tabBarItem = UITabBarItem(title: "Explore", image: UIImage(systemName: "safari"), tag: 1)
        cameraNavigationController.tabBarItem = UITabBarItem(title: "Camera", image: UIImage(systemName: "camera"), tag: 1)
        notificationsNavigationController.tabBarItem = UITabBarItem(title: "Notifications", image: UIImage(systemName: "bell"), tag: 1)
        profileNavigationController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.circle"), tag: 1)
        
        mainTabBarController?.setViewControllers([
            homeNavigationController,
            exploreNavigationController,
            cameraNavigationController,
            notificationsNavigationController,
            profileNavigationController
        ],
            animated: false
        )
        
        let homeFlowCoordinator = HomeCoordinator(navigationController: homeNavigationController)
        let exploreFlowCoordinator = ExploreCoordinator(navigationController: exploreNavigationController)
        let cameraFlowCoordinator = CameraCoordinator(navigationController: cameraNavigationController)
        let notificationsFlowCoordinator = NotificationsCoordinator(navigationController: notificationsNavigationController)
        let profileFlowCoordinator = ProfileCoordinator(navigationController: profileNavigationController)
        
        let childCoordinators: [Coordinator] = [
            homeFlowCoordinator,
            exploreFlowCoordinator,
            cameraFlowCoordinator,
            notificationsFlowCoordinator,
            profileFlowCoordinator
        ]
        self.childCoordinators.append(contentsOf: childCoordinators)
        
        childCoordinators.forEach { coordinator in
            coordinator.start()
        }
    }
    
    func showSignIn() {
        let authenticationCoordinator = AuthenticationCoordinator(navigationController: signInNavigationController ?? UINavigationController())
        authenticationCoordinator.delegate = self
        authenticationCoordinator.start()
        childCoordinators.append(authenticationCoordinator)
    }
}

extension AppCoordinator: AuthenticationCoordinatorDelegate {
    func didAuthenticate() {
        showMainScreen()
    }
}
