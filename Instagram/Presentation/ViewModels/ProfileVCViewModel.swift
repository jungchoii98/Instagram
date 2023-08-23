//
//  ProfileVCViewModel.swift
//  Instagram
//
//  Created by Jung Choi on 7/30/23.
//

import Foundation

class ProfileVCViewModel {
    
    let user: User
    private let userRepository: UserRepositoryProtocol
    
    init(
        user: User,
        userRepository: UserRepositoryProtocol
    ) {
        self.user = user
        self.userRepository = userRepository
    }
    
    func isCurrentUser() throws -> Bool {
        let loggedInUser = try userRepository.getLoggedInUser()
        return user.username == loggedInUser.username ? true : false
    }
}
