//
//  NotificationsCoordinator.swift
//  Instagram
//
//  Created by Jung Choi on 7/26/23.
//

import UIKit

final class NotificationsCoordinator: Coordinator {
    
    private let navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showNotifications()
    }
    
    private func showNotifications() {
        let notificationsVC = NotificationsViewController()
        notificationsVC.coordinator = self
        navigationController.pushViewController(notificationsVC, animated: true)
    }
}

extension NotificationsCoordinator: NotificationsViewControllerDelegate {}
