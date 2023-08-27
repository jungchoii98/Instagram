//
//  Post.swift
//  Instagram
//
//  Created by Jung Choi on 7/26/23.
//

import Foundation

struct Post: Codable, Hashable {
    let id: String
    let userID: String
    let username: String
    let avatarImageURL: String
    let postImageURL: String
    let likers: [String]
    let caption: String
    let timestamp: String
}
