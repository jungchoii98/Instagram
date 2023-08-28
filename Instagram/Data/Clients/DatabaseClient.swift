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
    func create(path: String, data: [String:Any]) async throws
    func find(path: String, completion: @escaping ([[String:Any]]?) -> Void)
    func find(path: String) async throws -> [[String:Any]]
    func remove(path: String) async throws
    func update(path: String, data: [AnyHashable:Any]) async throws
}

extension Firestore: DatabaseClient {
    func create(path: String, data: [String:Any], completion: @escaping (Bool) -> Void) {
        let documentReference = document(path)
        documentReference.setData(data) { error in
            completion(error == nil)
        }
    }
    
    func create(path: String, data: [String:Any]) async throws {
        let documentReference = document(path)
        try await documentReference.setData(data)
    }
    
    func find(path: String, completion: @escaping ([[String:Any]]?) -> Void) {
        let collectionReference = collection(path)
        collectionReference.getDocuments { snapshot, error in
            guard let documents = snapshot?.documents, error == nil else { completion(nil); return }
            let data = documents.compactMap({ $0.data() })
            completion(data)
        }
    }
    
    func find(path: String) async throws -> [[String:Any]] {
        let collectionReference = collection(path)
        let snapshot = try await collectionReference.getDocuments()
        let documents = snapshot.documents
        let data = documents.compactMap({ $0.data() })
        return data
    }
    
    func remove(path: String) async throws {
        let documentReference = document(path)
        try await documentReference.delete()
    }
    
    func update(path: String, data: [AnyHashable:Any]) async throws {
        let documentReference = document(path)
        try await documentReference.updateData(data)
    }
}
