//
//  DatabaseManager.swift
//  Instagram
//
//  Created by Jung Choi on 7/26/23.
//

import FirebaseFirestore
import Foundation

protocol DatabaseManagerProtocol {
    
}

protocol DatabaseSession {
    
}

final class DatabaseManager: DatabaseManagerProtocol {
    
    private let database: DatabaseSession
    
    init(database: DatabaseSession = Firestore.firestore()) {
        self.database = database
    }
}

extension Firestore: DatabaseSession {}
