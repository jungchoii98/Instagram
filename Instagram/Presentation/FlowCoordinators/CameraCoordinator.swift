//
//  CameraCoordinator.swift
//  Instagram
//
//  Created by Jung Choi on 7/26/23.
//

import UIKit

final class CameraCoordinator: Coordinator {
    
    private let navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
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
        let viewModel = CaptionVCViewModel()
        let captionVC = CaptionViewController(image: image, viewModel: viewModel)
        captionVC.coordinator = self
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

extension CameraCoordinator: CaptionViewControllerDelegate {
    
}
