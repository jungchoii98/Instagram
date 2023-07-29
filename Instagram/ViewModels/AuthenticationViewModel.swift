//
//  AuthenticationViewModel.swift
//  Instagram
//
//  Created by Jung Choi on 7/27/23.
//

import Foundation

class AuthenticationViewModel {
    
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
}
