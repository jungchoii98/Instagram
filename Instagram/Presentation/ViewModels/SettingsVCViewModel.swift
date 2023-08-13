//
//  SettingsVCViewModel.swift
//  Instagram
//
//  Created by Jung Choi on 8/12/23.
//

import Foundation

class SettingsVCViewModel {
    
    private let authManager: AuthServiceProtocol
    
    init(authManager: AuthServiceProtocol) {
        self.authManager = authManager
    }
    
    func signOut(completion: @escaping (Bool) -> Void) {
        authManager.signOut(completion: completion)
    }
}
