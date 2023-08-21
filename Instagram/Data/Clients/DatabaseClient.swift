//
//  DatabaseClient.swift
//  Instagram
//
//  Created by Jung Choi on 8/12/23.
//

import FirebaseFirestore
import Foundation

protocol DatabaseClient {
    func create(path: String, data: [String:Any], completion: @escaping (Bool) -> Void)
    func find(path: String, completion: @escaping ([[String:Any]]?) -> Void)
}

extension Firestore: DatabaseClient {
    func create(path: String, data: [String:Any], completion: @escaping (Bool) -> Void) {
        let documentReference = document(path)
        documentReference.setData(data) { error in
            completion(error == nil)
        }
    }
    
    func find(path: String, completion: @escaping ([[String:Any]]?) -> Void) {
        let collectionReference = collection(path)
        collectionReference.getDocuments { snapshot, error in
            guard let documents = snapshot?.documents, error == nil else { completion(nil); return }
            let data = documents.compactMap({ $0.data() })
            completion(data)
        }
    }
}
