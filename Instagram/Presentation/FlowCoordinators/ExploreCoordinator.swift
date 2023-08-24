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
    private let userRepository: UserRepositoryProtocol
    private let postRepository: PostRepositoryProtocol
    
    init(
        navigationController: UINavigationController,
        userRepository: UserRepositoryProtocol,
        postRepository: PostRepositoryProtocol
    ) {
        self.navigationController = navigationController
        self.userRepository = userRepository
        self.postRepository = postRepository
    }
    
    func start() {
        showExplore()
    }
    
    private func showExplore() {
        let viewModel = ExploreViewModel(userRepository: userRepository, postRepository: postRepository)
        let exploreVC = ExploreViewController(viewModel: viewModel)
        exploreVC.coordinator = self
        navigationController.pushViewController(exploreVC, animated: false)
    }
    
    private func showProfile(user: User) {
        let viewModel = ProfileVCViewModel(user: user, userRepository: userRepository)
        let profileVC = ProfileViewController(viewModel: viewModel)
        navigationController.pushViewController(profileVC, animated: true)
    }
}

extension ExploreCoordinator: ExploreViewControllerDelegate {
    func exploreViewControllerDidSelectUser(_ exploreViewController: ExploreViewController, user: User) {
        showProfile(user: user)
    }
}
