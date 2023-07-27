//
//  ProfileCoordinator.swift
//  Instagram
//
//  Created by Jung Choi on 7/26/23.
//

import UIKit

final class ProfileCoordinator: Coordinator {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showProfile()
    }
    
    private func showProfile() {
        let profileVC = ProfileViewController()
        profileVC.delegate = self
        navigationController.pushViewController(profileVC, animated: true)
    }
}

extension ProfileCoordinator: ProfileViewControllerDelegate {}
