//
//  DatabaseClient.swift
//  Instagram
//
//  Created by Jung Choi on 8/12/23.
//

import FirebaseFirestore
import Foundation

protocol DatabaseClient {
    func createUser(key: String, data: [String:Any], completion: @escaping (Bool) -> Void)
    func findUser(completion: @escaping ([[String:Any]]?) -> Void)
}

extension Firestore: DatabaseClient {
    func createUser(key: String, data: [String:Any], completion: @escaping (Bool) -> Void) {
        let document = document("users/\(key)")
        document.setData(data) { error in
            completion(error == nil)
        }
    }
    
    func findUser(completion: @escaping ([[String:Any]]?) -> Void) {
        let collection = collection("users")
        collection.getDocuments { snapshot, error in
            guard let usersDocuments = snapshot?.documents, error == nil else {
                completion(nil)
                return
            }
            let usersData = usersDocuments.compactMap({ $0.data() })
            completion(usersData)
        }
    }
}
