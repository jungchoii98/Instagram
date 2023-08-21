//
//  StorageClient.swift
//  Instagram
//
//  Created by Jung Choi on 8/12/23.
//

import FirebaseStorage
import Foundation

protocol StorageClient {
    func upload(filePath: String, itemName: String, data: Data, completion: @escaping (URL?) -> Void)
}

extension FirebaseStorage.Storage: StorageClient {
    func upload(filePath: String, itemName: String, data: Data, completion: @escaping (URL?) -> Void) {
        let reference = reference().child("\(filePath)/\(itemName)")
        reference.putData(data) { _, error in
            guard error == nil else { completion(nil); return }
            reference.downloadURL { url, error in
                if let url = url {
                    completion(url)
                } else {
                    completion(nil)
                }
            }
        }
    }
}
