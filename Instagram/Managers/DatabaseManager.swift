//
//  DatabaseManager.swift
//  Instagram
//
//  Created by Jung Choi on 7/26/23.
//

import FirebaseFirestore
import Foundation

final class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private init() {}
    
    let database = Firestore.firestore()
}
