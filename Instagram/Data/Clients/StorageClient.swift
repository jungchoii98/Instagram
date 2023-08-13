//
//  StorageClient.swift
//  Instagram
//
//  Created by Jung Choi on 8/12/23.
//

import FirebaseStorage
import Foundation

protocol StorageClient {
    func upload(fileName: String, itemName: String, data: Data, completion: @escaping (Bool) -> Void)
}

extension FirebaseStorage.Storage: StorageClient {
    func upload(fileName: String, itemName: String, data: Data, completion: @escaping (Bool) -> Void) {
        let reference = reference()
        reference.child("\(fileName)/\(itemName)").putData(data) { _, error in
            completion(error == nil)
        }
    }
}
