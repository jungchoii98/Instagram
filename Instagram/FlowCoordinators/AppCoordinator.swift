//
//  AppCoordinator.swift
//  Instagram
//
//  Created by Jung Choi on 7/26/23.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    func start()
}

final class AppCoordinator {
    
    private var navigationController = UINavigationController()
    
    private var authManager: AuthManagerProtocol = AuthManager(database: DatabaseManager())
    private var childCoordinators: [Coordinator] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        if authManager.isSignedIn {
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
        
        let mainTabBarController = UITabBarController()
        
        mainTabBarController.setViewControllers([
            homeNavigationController,
            exploreNavigationController,
            cameraNavigationController,
            notificationsNavigationController,
            profileNavigationController
        ],
            animated: false
        )
        
        navigationController.pushViewController(mainTabBarController, animated: true)
    }
    
    func showSignIn() {
        let authenticationCoordinator = AuthenticationCoordinator(navigationController: navigationController)
        authenticationCoordinator.delegate = self
        authenticationCoordinator.start()
        childCoordinators.append(authenticationCoordinator)
    }
}

// MARK: Delegates

extension AppCoordinator: AuthenticationCoordinatorDelegate {
    func didAuthenticate(child: Coordinator) {
        removeChild(child: child)
        showMainScreen()
    }
}

// MARK: Extensions

extension AppCoordinator {
    private func removeChild(child: Coordinator) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if child === coordinator {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}
