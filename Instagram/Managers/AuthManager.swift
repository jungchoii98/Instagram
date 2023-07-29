//
//  AuthManager.swift
//  Instagram
//
//  Created by Jung Choi on 7/26/23.
//

import FirebaseAuth
import Foundation

protocol AuthManagerProtocol {
    var isSignedIn: Bool { get }
    func signIn(
        email: String,
        password: String,
        completion: @escaping (Result<IGUser,Error>) -> Void
    )
    func signUp(
        email: String,
        password: String,
        username: String,
        profileImage: Data?,
        completion: @escaping (Result<IGUser,Error>) -> Void
    )
    func signOut(completion: @escaping (Bool) -> Void)
}

protocol Authenticator {
    var currentUser: User? { get }
    func createUser(withEmail: String, password: String, completion: ((AuthDataResult?, Error?) -> Void)?)
}

final class AuthManager: AuthManagerProtocol {
    
    private let auth: Authenticator
    private let database: DatabaseManagerProtocol
    
    var isSignedIn: Bool {
        return auth.currentUser != nil ? true : false
    }
    
    init(auth: Authenticator = FirebaseAuth.Auth.auth(), database: DatabaseManagerProtocol) {
        self.auth = auth
        self.database = database
    }
    
    func signIn(
        email: String,
        password: String,
        completion: @escaping (Result<IGUser, Error>) -> Void
    ) {
        
    }
    
    public func signUp(
        email: String,
        password: String,
        username: String,
        profileImage: Data?,
        completion: @escaping (Result<IGUser, Error>) -> Void
    ) {
        auth.createUser(withEmail: email, password: password) { result, error in
            
        }
    }
    
    func signOut(completion: @escaping (Bool) -> Void) {
        
    }
}

extension Auth: Authenticator {}
