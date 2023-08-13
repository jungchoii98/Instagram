//
//  DatabaseManager.swift
//  Instagram
//
//  Created by Jung Choi on 7/26/23.
//

import Foundation

protocol DatabaseManagerProtocol {
    func createUser(user: IGUser, completion: @escaping (Bool) -> Void)
    func findUser(email: String, completion: @escaping (IGUser?) -> Void)
}

final class DatabaseManager: DatabaseManagerProtocol {
    
    private let databaseClient: DatabaseClient
    
    init(databaseClient: DatabaseClient) {
        self.databaseClient = databaseClient
    }
    
    public func createUser(user: IGUser, completion: @escaping (Bool) -> Void) {
        guard let documentData = user.asJsonObject() else {
            completion(false)
            return
        }
        databaseClient.createUser(key: user.username, data: documentData) { didSucceed in
            completion(didSucceed)
        }
    }
    
    public func findUser(email: String, completion: @escaping (IGUser?) -> Void) {
        databaseClient.findUser { usersData in
            guard let usersData = usersData else {
                completion(nil)
                return
            }
            let users = usersData.compactMap({ IGUser(dictionary: $0) })
            completion(
                users.first(where: { $0.email == email })
            )
        }
    }
}
