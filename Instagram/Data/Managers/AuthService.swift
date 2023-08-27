//
//  AuthService.swift
//  Instagram
//
//  Created by Jung Choi on 7/26/23.
//

import Foundation

protocol AuthServiceProtocol {
    var isSignedIn: Bool { get }
    func signIn(
        email: String,
        password: String,
        completion: @escaping (Result<User,AuthError>) -> Void
    )
    func signUp(
        email: String,
        password: String,
        username: String,
        profileImageData: Data?,
        completion: @escaping (Result<User,AuthError>) -> Void
    )
    func signOut(completion: @escaping (Bool) -> Void)
}

final class AuthService: AuthServiceProtocol {
    
    private let authClient: AuthClient
    private let databaseManager: DatabaseManagerProtocol
    private let storageManager: StorageManagerProtocol
    
    init(
        authClient: AuthClient,
        databaseManager: DatabaseManagerProtocol,
        storageManager: StorageManagerProtocol
    ) {
        self.authClient = authClient
        self.databaseManager = databaseManager
        self.storageManager = storageManager
    }
    
    var isSignedIn: Bool {
        return authClient.isSignedIn()
    }
    
    public func signIn(
        email: String,
        password: String,
        completion: @escaping (Result<User,AuthError>) -> Void
    ) {
        databaseManager.findUser(email: email) { [weak self] user in
            guard let self = self,
                  let user = user else {
                completion(.failure(.signInError))
                return
            }
            self.authClient.signIn(withEmail: email, password: password) { didSucceed in
                guard didSucceed else {
                    completion(.failure(.signInError))
                    return
                }
                completion(.success(user))
            }
        }
    }
    
    public func signUp(
        email: String,
        password: String,
        username: String,
        profileImageData: Data?,
        completion: @escaping (Result<User,AuthError>) -> Void
    ) {
        let userID = UUID().uuidString
        storageManager.uploadProfilePicture(userID: userID, pictureData: profileImageData) { [weak self] url in
            guard let url = url else { completion(.failure(.uploadProfilePictureError)); return }
            let user = User(id: userID, username: username, email: email, profileImageURL: url.absoluteString)
            self?.databaseManager.createUser(user: user, completion: { [weak self] didSucceed in
                guard didSucceed else { completion(.failure(.createUserError)); return }
                self?.authClient.createUser(withEmail: email, password: password, completion: { didSucceed in
                    guard didSucceed else { completion(.failure(.createUserError)); return }
                    completion(.success(user))
                })
            })
        }
    }
    
    public func signOut(completion: @escaping (Bool) -> Void) {
        do {
            try authClient.signOut()
            completion(true)
        } catch {
            completion(false)
        }
    }
}

enum AuthError: Error {
    case createUserError
    case uploadProfilePictureError
    case signInError
}
