//
//  DatabaseManager.swift
//  Instagram
//
//  Created by Jung Choi on 7/26/23.
//

import Foundation

protocol DatabaseManagerProtocol {
    func createUser(user: User, completion: @escaping (Bool) -> Void)
    func createPost(username: String, post: Post, completion: @escaping (Bool) -> Void)
    func findUser(email: String, completion: @escaping (User?) -> Void)
    func getUsers(completion: @escaping ([User]) -> Void)
    func fetchPosts(for username: String, completion: @escaping ([Post]?) -> Void)
    func fetchAllPosts(completion: @escaping ([Post]) -> Void)
}

final class DatabaseManager: DatabaseManagerProtocol {
    
    private let databaseClient: DatabaseClient
    
    init(databaseClient: DatabaseClient) {
        self.databaseClient = databaseClient
    }
    
    public func createUser(user: User, completion: @escaping (Bool) -> Void) {
        guard let documentData = user.asJsonObject() else { completion(false); return }
        databaseClient.create(path: "users/\(user.username)", data: documentData) { didSucceed in
            completion(didSucceed)
        }
    }
    
    public func createPost(username: String, post: Post, completion: @escaping (Bool) -> Void) {
        guard let documentData = post.asJsonObject() else { completion(false); return }
        databaseClient.create(path: "users/\(username)/posts/\(post.id)", data: documentData) { didSucceed in
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
    
    public func fetchPosts(for username: String, completion: @escaping ([Post]?) -> Void) {
        databaseClient.find(path: "users/\(username)/posts") { postsData in
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
                self.fetchPosts(for: user.username) { posts in
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
}
