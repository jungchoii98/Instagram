//
//  StorageManager.swift
//  Instagram
//
//  Created by Jung Choi on 7/26/23.
//

import FirebaseStorage
import Foundation

protocol StorageManagerProtocol {
    func uploadProfilePicture(
        userID: String,
        pictureData: Data?,
        completion: @escaping (URL?) -> Void
    )
    
    func uploadPost(
        userID: String,
        postID: String,
        pictureData: Data?,
        completion: @escaping (URL?) -> Void
    )
}

final class StorageManager: StorageManagerProtocol {
    
    private let storageClient: StorageClient
    
    init(storageClient: StorageClient) {
        self.storageClient = storageClient
    }
    
    public func uploadProfilePicture(
        userID: String,
        pictureData: Data?,
        completion: @escaping (URL?) -> Void
    ) {
        guard let data = pictureData else { completion(nil); return }
        storageClient.upload(filePath: userID, itemName: "profile_picture.png", data: data) { url in
            completion(url)
        }
    }
    
    public func uploadPost(
        userID: String,
        postID: String,
        pictureData: Data?,
        completion: @escaping (URL?) -> Void
    ) {
        guard let data = pictureData else { completion(nil); return }
        storageClient.upload(filePath: "\(userID)/posts", itemName: postID + ".png", data: data) { url in
            completion(url)
        }
    }
}
