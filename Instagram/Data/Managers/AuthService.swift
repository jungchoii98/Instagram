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
        completion: @escaping (Result<IGUser,AuthError>) -> Void
    )
    func signUp(
        email: String,
        password: String,
        username: String,
        profileImageData: Data?,
        completion: @escaping (Result<IGUser,AuthError>) -> Void
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
        completion: @escaping (Result<IGUser,AuthError>) -> Void
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
        completion: @escaping (Result<IGUser,AuthError>) -> Void
    ) {
        authClient.createUser(withEmail: email, password: password) { [weak self] didSucceed in
            guard let self = self,
                  didSucceed else {
                completion(.failure(.createUserError))
                return
            }
            let user = IGUser(username: username, email: email)
            self.databaseManager.createUser(user: user) { [weak self] didSucceed in
                guard let self = self,
                      didSucceed else {
                    completion(.failure(.createUserError))
                    return
                }
                self.storageManager.uploadProfilePicture(
                    username: username,
                    pictureData: profileImageData
                ) { pictureDidUpload in
                    if pictureDidUpload {
                        completion(.success(user))
                    } else {
                        completion(.failure(.uploadProfilePictureError))
                    }
                }
            }
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