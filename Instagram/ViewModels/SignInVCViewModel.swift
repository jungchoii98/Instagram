//
//  SignInVCViewModel.swift
//  Instagram
//
//  Created by Jung Choi on 7/27/23.
//

import Foundation

class SignInVCViewModel {
    
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
}
