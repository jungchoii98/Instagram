//
//  AuthClient.swift
//  Instagram
//
//  Created by Jung Choi on 8/12/23.
//

import FirebaseAuth
import Foundation

protocol AuthClient {
    func isSignedIn() -> Bool
    func signOut() throws
    func signIn(withEmail: String, password: String, completion: @escaping (Bool) -> Void)
    func createUser(withEmail: String, password: String, completion: @escaping (Bool) -> Void)
}

extension FirebaseAuth.Auth: AuthClient {
    
    func isSignedIn() -> Bool {
        return currentUser != nil ? true : false
    }
    
    func signIn(withEmail: String, password: String, completion: @escaping (Bool) -> Void) {
        signIn(withEmail: withEmail, password: password) { result, error in
            guard result != nil, error == nil else { completion(false); return }
            completion(true)
        }
    }
    
    func createUser(withEmail: String, password: String, completion: @escaping (Bool) -> Void) {
        createUser(withEmail: withEmail, password: password) { result, error in
            guard result != nil, error == nil else {
                completion(false)
                return
            }
            completion(true)
        }
    }
}
