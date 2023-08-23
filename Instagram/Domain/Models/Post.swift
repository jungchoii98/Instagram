//
//  Post.swift
//  Instagram
//
//  Created by Jung Choi on 7/26/23.
//

import Foundation

struct Post: Codable, Hashable {
    let username: String
    let avatarImageURL: String
    let postImageURL: String
    let likers: [String]
    let caption: String
    let timestamp: String
    
    var id: String {
        return UUID().uuidString
    }
}
