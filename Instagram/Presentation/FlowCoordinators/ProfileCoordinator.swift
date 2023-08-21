//
//  ProfileCoordinator.swift
//  Instagram
//
//  Created by Jung Choi on 7/26/23.
//

import UIKit

final class ProfileCoordinator: Coordinator {
    
    private let navigationController: UINavigationController
    weak var appCoordinator: AppCoordinator?
    var childCoordinators: [Coordinator] = []
    private let authManager: AuthServiceProtocol
    private let user: User
    
    init(navigationController: UINavigationController, authManager: AuthServiceProtocol, user: User) {
        self.navigationController = navigationController
        self.authManager = authManager
        self.user = user
    }
    
    func start() {
        showProfile()
    }
    
    private func showProfile() {
        let viewModel = ProfileVCViewModel()
        let profileVC = ProfileViewController(viewModel: viewModel, user: user)
        profileVC.coordinator = self
        navigationController.pushViewController(profileVC, animated: false)
    }
    
    private func showSettings() {
        let viewModel = SettingsVCViewModel(authManager: authManager)
        let settingsVC = SettingsViewController(viewModel: viewModel)
        settingsVC.coordinator = self
        navigationController.present(UINavigationController(rootViewController: settingsVC), animated: true)
    }
}

extension ProfileCoordinator: ProfileViewControllerDelegate {
    func didTapSettings() {
        showSettings()
    }
}

extension ProfileCoordinator: SettingsViewControllerDelegate {
    func didTapSignOut() {
        appCoordinator?.didSignOut(child: self)
    }
}
