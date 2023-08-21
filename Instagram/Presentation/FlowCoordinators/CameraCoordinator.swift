//
//  CameraCoordinator.swift
//  Instagram
//
//  Created by Jung Choi on 7/26/23.
//

import UIKit

final class CameraCoordinator: Coordinator {
    
    private let tabBarController: UITabBarController
    private let navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    private let username: String
    private let postRepository: PostRepositoryProtocol
    
    init(
        tabBarController: UITabBarController,
        navigationController: UINavigationController,
        username: String,
        postRepository: PostRepositoryProtocol
    ) {
        self.tabBarController = tabBarController
        self.navigationController = navigationController
        self.username = username
        self.postRepository = postRepository
    }
    
    func start() {
        showCamera()
    }
    
    private func showCamera() {
        let cameraVC = CameraViewController()
        cameraVC.coordinator = self
        navigationController.pushViewController(cameraVC, animated: false)
    }
    
    private func showCameraEdit(with image: UIImage) {
        let editVC = CameraEditViewController(image: image)
        editVC.coordinator = self
        navigationController.pushViewController(editVC, animated: false)
    }
    
    private func showCaption(with image: UIImage) {
        let viewModel = CaptionVCViewModel(postRepository: postRepository, username: username)
        let captionVC = CaptionViewController(image: image, viewModel: viewModel)
        navigationController.pushViewController(captionVC, animated: false)
    }
}

extension CameraCoordinator: CameraViewControllerDelegate {
    func cameraViewControllerDidCapturePhoto(_ cameraViewController: CameraViewController, with image: UIImage) {
        showCameraEdit(with: image)
    }
}

extension CameraCoordinator: CameraEditViewControllerDelegate {
    func cameraEditViewControllerDidTapNext(_ cameraEditViewController: CameraEditViewController, with image: UIImage) {
        showCaption(with: image)
    }
}
