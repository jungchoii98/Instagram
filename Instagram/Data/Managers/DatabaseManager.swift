//
//  DatabaseManager.swift
//  Instagram
//
//  Created by Jung Choi on 7/26/23.
//

import Foundation

protocol DatabaseManagerProtocol {
    func createUser(user: User, completion: @escaping (Bool) -> Void)
    func findUser(email: String, completion: @escaping (User?) -> Void)
    func getUsers(completion: @escaping ([User]) -> Void)
    
    func createPost(userID: String, post: Post, completion: @escaping (Bool) -> Void)
    func fetchPosts(userID: String, completion: @escaping ([Post]?) -> Void)
    func fetchAllPosts(completion: @escaping ([Post]) -> Void)
    
    func fetchNotifications(userID: String) async throws -> [IGNotification]
    func createNotification(userID: String, notification: IGNotification) async throws
}

final class DatabaseManager: DatabaseManagerProtocol {
    
    private let databaseClient: DatabaseClient
    
    init(databaseClient: DatabaseClient) {
        self.databaseClient = databaseClient
    }
    
    // MARK: - User
    
    public func createUser(user: User, completion: @escaping (Bool) -> Void) {
        guard let documentData = user.asJsonObject() else { completion(false); return }
        databaseClient.create(path: "users/\(user.id)", data: documentData) { didSucceed in
            completion(didSucceed)
        }
    }
    
    public func findUser(email: String, completion: @escaping (User?) -> Void) {
        databaseClient.find(path: "users") { usersData in
            guard let usersData = usersData else { completion(nil); return }
            let users = usersData.compactMap({ User(dictionary: $0) })
            completion(
                users.first(where: { $0.email == email })
            )
        }
    }
    
    public func getUsers(completion: @escaping ([User]) -> Void) {
        databaseClient.find(path: "users") { usersData in
            guard let usersData = usersData else { completion([]); return }
            let users = usersData.compactMap({ User(dictionary: $0) })
            completion(users)
        }
    }
    
    // MARK: - Post
    
    public func createPost(userID: String, post: Post, completion: @escaping (Bool) -> Void) {
        guard let documentData = post.asJsonObject() else { completion(false); return }
        databaseClient.create(path: "users/\(userID)/posts/\(post.id)", data: documentData) { didSucceed in
            completion(didSucceed)
        }
    }
    
    public func fetchPosts(userID: String, completion: @escaping ([Post]?) -> Void) {
        databaseClient.find(path: "users/\(userID)/posts") { postsData in
            guard let postsData = postsData else { completion(nil); return }
            let posts = postsData.compactMap({ Post(dictionary: $0) })
            completion(posts)
        }
    }
    
    public func fetchAllPosts(completion: @escaping ([Post]) -> Void) {
        getUsers { [weak self] users in
            guard let self = self else { completion([]); return }
            let group = DispatchGroup()
            var result = [Post]()
            users.forEach { user in
                group.enter()
                self.fetchPosts(userID: user.id) { posts in
                    defer {
                        group.leave()
                    }
                    guard let posts = posts else { completion([]); return }
                    result.append(contentsOf: posts)
                }
            }
            group.notify(queue: .main) {
                completion(result)
            }
        }
    }
    
    // MARK: - Notification
    
    /// - Parameters:
    ///   - userID: A string identifying the current logged in user
    public func fetchNotifications(
        userID: String
    ) async throws -> [IGNotification] {
        try await withCheckedThrowingContinuation({ continuation in
            databaseClient.find(path: "users/\(userID)/notifications") { notificationsData in
                guard let notificationsData = notificationsData else {
                    continuation.resume(throwing: DatabaseError.badData)
                    return
                }
                let notifications = notificationsData.compactMap({ IGNotification(dictionary: $0) })
                continuation.resume(returning: notifications)
            }
        })
    }
    
    /// - Parameters:
    ///   - userID: A string identifying the receiver of the notification
    ///   - notification: A newly created notification
    public func createNotification(
        userID: String,
        notification: IGNotification
    ) async throws {
        try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<Void,Error>) in
            guard let notificationData = notification.asJsonObject() else {
                continuation.resume(throwing: DatabaseError.badData)
                return
            }
            databaseClient.create(path: "users/\(userID)/notifications/\(notification.id)", data: notificationData) { didSucceed in
                if didSucceed {
                    continuation.resume()
                } else {
                    continuation.resume(throwing: DatabaseError.badData)
                }
            }
        })
    }
}

enum DatabaseError: Error {
    case badData
}
