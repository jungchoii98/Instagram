//
//  PostRepository.swift
//  Instagram
//
//  Created by Jung Choi on 8/21/23.
//

import Foundation

protocol PostRepositoryProtocol {
    func storePost(
        username: String,
        postID: String,
        pictureData: Data?,
        completion: @escaping (URL?) -> Void
    )
    
    func uploadPost(
        username: String,
        post: Post,
        completion: @escaping (Bool) -> Void
    )
}

class PostRepository: PostRepositoryProtocol {
    
    private let storageManager: StorageManagerProtocol
    private let databaseManager: DatabaseManagerProtocol
    
    init(
        storageManager: StorageManagerProtocol,
        databaseManager: DatabaseManagerProtocol
    ) {
        self.storageManager = storageManager
        self.databaseManager = databaseManager
    }
    
    func storePost(
        username: String,
        postID: String,
        pictureData: Data?,
        completion: @escaping (URL?) -> Void
    ) {
        storageManager.uploadPost(username: username, postID: postID, pictureData: pictureData) { url in
            completion(url)
        }
    }
    
    func uploadPost(
        username: String,
        post: Post,
        completion: @escaping (Bool) -> Void
    ) {
        databaseManager.createPost(username: username, post: post) { didSucceed in
            completion(didSucceed)
        }
    }
}
