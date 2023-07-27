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
}

final class AuthManager: AuthManagerProtocol {
    
    private let auth: Authenticator
    
    var isSignedIn: Bool {
        return auth.currentUser != nil ? true : false
    }
    
    init(auth: Authenticator = FirebaseAuth.Auth.auth()) {
        self.auth = auth
    }
    
    func signIn(
        email: String,
        password: String,
        completion: @escaping (Result<IGUser, Error>) -> Void
    ) {
        
    }
    
    func signUp(
        email: String,
        password: String,
        username: String,
        profileImage: Data?,
        completion: @escaping (Result<IGUser, Error>) -> Void
    ) {
        
    }
    
    func signOut(completion: @escaping (Bool) -> Void) {
        
    }
}

extension Auth: Authenticator {}
