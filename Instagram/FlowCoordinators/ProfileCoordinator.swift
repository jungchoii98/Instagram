//
//  ProfileCoordinator.swift
//  Instagram
//
//  Created by Jung Choi on 7/26/23.
//

import UIKit

class ProfileCoordinator: Coordinator {
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showProfile()
    }
    
    func showProfile() {
        let profileVC = ProfileViewController()
        profileVC.delegate = self
        navigationController.pushViewController(profileVC, animated: false)
    }
}

extension ProfileCoordinator: ProfileViewControllerDelegate {}
