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
        navigationController.pushViewController(cameraVC, animated: true)
    }
}

extension CameraCoordinator: CameraViewControllerDelegate {}
