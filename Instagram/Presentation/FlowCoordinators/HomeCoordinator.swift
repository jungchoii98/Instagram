//
//  HomeCoordinator.swift
//  Instagram
//
//  Created by Jung Choi on 7/26/23.
//

import UIKit

final class HomeCoordinator: Coordinator {
    
    private let navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    private let postRepository: PostRepositoryProtocol
    private let userRepository: UserRepositoryProtocol
    
    init(
        navigationController: UINavigationController,
        postRepository: PostRepositoryProtocol,
        userRepository: UserRepositoryProtocol
    ) {
        self.navigationController = navigationController
        self.postRepository = postRepository
        self.userRepository = userRepository
    }
    
    func start() {
        showHome()
    }
    
    private func showHome() {
        let viewModel = HomeFeedVCViewModel(postRepository: postRepository, userRepository: userRepository)
        let homeVC = HomeFeedViewController(viewModel: viewModel)
        homeVC.coordinator = self
        navigationController.pushViewController(homeVC, animated: false)
    }
}

extension HomeCoordinator: HomeFeedViewControllerDelegate {}
