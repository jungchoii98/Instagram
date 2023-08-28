//
//  NotificationRepository.swift
//  Instagram
//
//  Created by Jung Choi on 8/27/23.
//

import Foundation

protocol NotificationRepositoryProtocol {
    func getNotifications() async throws -> [IGNotification]
    func createNotification(userID: String, notification: IGNotification) async throws
}

class NotificationRepository: NotificationRepositoryProtocol {
    
    private let databaseManager: DatabaseManagerProtocol
    
    init(databaseManager: DatabaseManagerProtocol) {
        self.databaseManager = databaseManager
    }
    
    func getNotifications() async throws -> [IGNotification] {
        guard let data = UserDefaults.standard.object(forKey: UserDefaultsConstants.user.rawValue) as? Data,
              let loggedInUser = Utility.decode(User.self, data: data) else {
            throw UserDefaultsError.userDataError
        }
        let notifications = try await databaseManager.fetchNotifications(userID: loggedInUser.id)
        return notifications
    }
    
    func createNotification(
        userID: String,
        notification: IGNotification
    ) async throws {
        try await databaseManager.createNotification(userID: userID, notification: notification)
    }
}
