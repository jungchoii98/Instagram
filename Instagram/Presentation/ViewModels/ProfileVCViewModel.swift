//
//  ProfileVCViewModel.swift
//  Instagram
//
//  Created by Jung Choi on 7/30/23.
//

import Foundation

class ProfileVCViewModel {
    
    func isCurrentUser(user: IGUser) throws -> Bool {
        guard let data = UserDefaults.standard.object(forKey: UserDefaultsConstants.user.rawValue) as? Data,
              let loggedInUser = Utility.decode(IGUser.self, data: data) else {
            throw ProfileViewController.ProfileErrors.badData
        }
        return user.username == loggedInUser.username ? true : false
    }
}
