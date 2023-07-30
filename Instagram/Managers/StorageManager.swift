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
    
    static let shared = StorageManager()
    
    private init() {}
    
    private let storage = FirebaseStorage.Storage.storage()
    
    public func uploadProfilePicture(
        username: String,
        pictureData: Data?,
        completion: @escaping (Bool) -> Void
    ) {
        guard let data = pictureData else {
            completion(false)
            return
        }
        let reference = storage.reference()
        reference.child("\(username)/profile_picture.png").putData(data) { _, error in
            completion(error == nil)
        }
    }
}
