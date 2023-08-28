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
    private let notificationRepository: NotificationRepositoryProtocol
    
    init(navigationController: UINavigationController, notificationRepository: NotificationRepositoryProtocol) {
        self.navigationController = navigationController
        self.notificationRepository = notificationRepository
    }
    
    func start() {
        showNotifications()
    }
    
    private func showNotifications() {
        let viewModel = NotificationViewModel(notificationRepository: notificationRepository)
        let notificationsVC = NotificationsViewController(viewModel: viewModel)
        notificationsVC.coordinator = self
        navigationController.pushViewController(notificationsVC, animated: false)
    }
}

extension NotificationsCoordinator: NotificationsViewControllerDelegate {}
