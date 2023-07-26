//
//  CameraCoordinator.swift
//  Instagram
//
//  Created by Jung Choi on 7/26/23.
//

import UIKit

class CameraCoordinator: Coordinator {
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showCamera()
    }
    
    func showCamera() {
        let cameraVC = CameraViewController()
        cameraVC.delegate = self
        navigationController.pushViewController(cameraVC, animated: false)
    }
}

extension CameraCoordinator: CameraViewControllerDelegate {}
