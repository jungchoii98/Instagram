//
//  NotificationsCoordinator.swift
//  Instagram
//
//  Created by Jung Choi on 7/26/23.
//

import UIKit

class NotificationsCoordinator: Coordinator {
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showNotifications()
    }
    
    func showNotifications() {
        let notificationsVC = NotificationsViewController()
        notificationsVC.delegate = self
        navigationController.pushViewController(notificationsVC, animated: false)
    }
}

extension NotificationsCoordinator: NotificationsViewControllerDelegate {}
