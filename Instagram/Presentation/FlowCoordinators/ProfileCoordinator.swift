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
    
    init(navigationController: UINavigationController, authManager: AuthServiceProtocol) {
        self.navigationController = navigationController
        self.authManager = authManager
    }
    
    func start() {
        showProfile()
    }
    
    private func showProfile() {
        guard let data = UserDefaults.standard.object(forKey: UserDefaultsConstants.user.rawValue) as? Data,
              let user = Utility.decode(IGUser.self, data: data) else {
            return
        }
        let viewModel = ProfileVCViewModel()
        let profileVC = ProfileViewController(viewModel: viewModel, user: user)
        profileVC.coordinator = self
        navigationController.pushViewController(profileVC, animated: true)
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
