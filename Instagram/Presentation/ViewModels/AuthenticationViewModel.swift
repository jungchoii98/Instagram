//
//  AuthenticationViewModel.swift
//  Instagram
//
//  Created by Jung Choi on 7/27/23.
//

import Foundation

class AuthenticationViewModel {
    
    private let authManager: AuthServiceProtocol
    
    init(authManager: AuthServiceProtocol) {
        self.authManager = authManager
    }
    
    func isValidSignIn(email: String, password: String) -> Bool {
        let email = email.trimmingCharacters(in: .whitespaces)
        let password = password.trimmingCharacters(in: .whitespaces)
        guard !email.isEmpty,
              !password.isEmpty,
              password.count > 6
        else {
            return false
        }
        return true
    }
    
    func isValidSignUp(username: String, email: String, password: String) -> Bool {
        let username = username.trimmingCharacters(in: .whitespaces)
        let email = email.trimmingCharacters(in: .whitespaces)
        let password = password.trimmingCharacters(in: .whitespaces)
        guard username.count >= 2,
              !email.isEmpty,
              password.count >= 6,
              username.trimmingCharacters(in: .alphanumerics).isEmpty
        else {
            return false
        }
        return true
    }
    
    func signUp(email: String, password: String, username: String, profileImageData: Data?, completion: @escaping (Error?) -> Void) {
        authManager.signUp(email: email, password: password, username: username, profileImageData: profileImageData) { result in
            switch result {
            case .success(let user):
                UserDefaults.standard.set(user.asData(), forKey: UserDefaultsConstants.user.rawValue)
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    func signIn(email: String, password: String, completion: @escaping (Error?) -> Void) {
        authManager.signIn(email: email, password: password) { result in
            switch result {
            case .success(let user):
                UserDefaults.standard.set(user.asData(), forKey: UserDefaultsConstants.user.rawValue)
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }
}
