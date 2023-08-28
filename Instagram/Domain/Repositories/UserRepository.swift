//
//  UserRepository.swift
//  Instagram
//
//  Created by Jung Choi on 8/22/23.
//

import Foundation

protocol UserRepositoryProtocol {
    func getUsers(completion: @escaping ([User]) -> Void)
    func getLoggedInUser() throws -> User
}

class UserRepository: UserRepositoryProtocol {
    
    private let storageManager: StorageManagerProtocol
    private let databaseManager: DatabaseManagerProtocol
    
    init(storageManager: StorageManagerProtocol, databaseManager: DatabaseManagerProtocol) {
        self.storageManager = storageManager
        self.databaseManager = databaseManager
    }
    
    func getUsers(completion: @escaping ([User]) -> Void) {
        databaseManager.getUsers(completion: completion)
    }
    
    func getLoggedInUser() throws -> User {
        guard let data = UserDefaults.standard.object(forKey: UserDefaultsConstants.user.rawValue) as? Data,
              let loggedInUser = Utility.decode(User.self, data: data) else {
            throw UserDefaultsError.userDataError
        }
        return loggedInUser
    }
}
