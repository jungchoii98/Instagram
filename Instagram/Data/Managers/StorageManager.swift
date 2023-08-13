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
        username: String,
        pictureData: Data?,
        completion: @escaping (Bool) -> Void
    )
}

final class StorageManager: StorageManagerProtocol {
    
    private let storageClient: StorageClient
    
    init(storageClient: StorageClient) {
        self.storageClient = storageClient
    }
    
    public func uploadProfilePicture(
        username: String,
        pictureData: Data?,
        completion: @escaping (Bool) -> Void
    ) {
        guard let data = pictureData else {
            completion(false)
            return
        }
        storageClient.upload(fileName: username, itemName: "profile_picture.png", data: data) { didSucceed in
            completion(didSucceed)
        }
    }
}
