//
//  StorageManager.swift
//  Instagram
//
//  Created by Jung Choi on 7/26/23.
//

import FirebaseStorage
import Foundation

final class StorageManager {
    
    static let shared = StorageManager()
    
    private init() {}
    
    let storage = FirebaseStorage.Storage.storage()
}
