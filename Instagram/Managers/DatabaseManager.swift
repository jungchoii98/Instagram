//
//  DatabaseManager.swift
//  Instagram
//
//  Created by Jung Choi on 7/26/23.
//

import FirebaseFirestore
import Foundation

protocol DatabaseManagerProtocol {
    func createUser(user: IGUser, completion: @escaping (Bool) -> Void)
}

final class DatabaseManager: DatabaseManagerProtocol {
    
    static let shared = DatabaseManager()
    
    private init() {}
    
    private let database = Firestore.firestore()
    
    public func createUser(user: IGUser, completion: @escaping (Bool) -> Void) {
        let document = database.document("users/\(user.username)")
        guard let documentData = user.asJsonObject() else {
            completion(false)
            return
        }
        document.setData(documentData) { error in
            completion(error == nil)
            return
        }
    }
}
