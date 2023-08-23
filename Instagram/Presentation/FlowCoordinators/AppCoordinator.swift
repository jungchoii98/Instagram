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
    
    private var childCoordinators: [Coordinator] = []
    private let authManager: AuthServiceProtocol
    private let postRepository: PostRepositoryProtocol
    private let userRepository: UserRepositoryProtocol
    
    init(
        navigationController: UINavigationController,
        authManager: AuthServiceProtocol,
        postRepository: PostRepositoryProtocol,
        userRepository: UserRepositoryProtocol
    ) {
        self.navigationController = navigationController
        self.authManager = authManager
        self.postRepository = postRepository
        self.userRepository = userRepository
    }
    
    func start() {
        if authManager.isSignedIn {
            showMainScreen()
        } else {
            showSignIn()
        }
    }
    
    private func showMainScreen() {
        guard let data = UserDefaults.standard.object(forKey: UserDefaultsConstants.user.rawValue) as? Data,
              let user = Utility.decode(User.self, data: data) else {
            return
        }
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
        profileNavigationController.navigationBar.tintColor = .label
        
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
        mainTabBarController.modalPresentationStyle = .fullScreen
        
        let homeFlowCoordinator = HomeCoordinator(
            navigationController: homeNavigationController,
            postRepository: postRepository
        )
        let exploreFlowCoordinator = ExploreCoordinator(
            navigationController: exploreNavigationController,
            userRepository: userRepository
        )
        let cameraFlowCoordinator = CameraCoordinator(
            tabBarController: mainTabBarController,
            navigationController: cameraNavigationController,
            user: user,
            postRepository: postRepository
        )
        let notificationsFlowCoordinator = NotificationsCoordinator(navigationController: notificationsNavigationController)
        let profileFlowCoordinator = ProfileCoordinator(
            navigationController: profileNavigationController,
            authManager: authManager,
            user: user,
            userRepository: userRepository
        )
        
        profileFlowCoordinator.appCoordinator = self
        
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
        
        navigationController.present(mainTabBarController, animated: true)
    }
    
    func showSignIn() {
        let authenticationCoordinator = AuthenticationCoordinator(navigationController: navigationController, authManager: authManager)
        authenticationCoordinator.delegate = self
        authenticationCoordinator.start()
        childCoordinators.append(authenticationCoordinator)
    }
    
    func didSignOut(child: Coordinator) {
        removeChild(child: child)
        DispatchQueue.main.async {
            self.navigationController.dismiss(animated: true)
            if self.navigationController.viewControllers.isEmpty {
                self.showSignIn()
            }
        }
    }
}

// MARK: Delegates

extension AppCoordinator: AuthenticationCoordinatorDelegate {
    func didAuthenticate(child: Coordinator) {
        removeChild(child: child)
        DispatchQueue.main.async {
            self.navigationController.popToRootViewController(animated: false)
            self.showMainScreen()
        }
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
