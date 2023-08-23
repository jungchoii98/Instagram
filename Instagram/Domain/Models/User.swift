//
//  User.swift
//  Instagram
//
//  Created by Jung Choi on 7/26/23.
//

import Foundation

struct User: Codable, Hashable {
    let username: String
    let email: String
    let profileImageURL: String
}
