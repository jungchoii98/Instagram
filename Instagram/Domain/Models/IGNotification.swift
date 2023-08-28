//
//  Notification.swift
//  Instagram
//
//  Created by Jung Choi on 7/26/23.
//

import Foundation

struct IGNotification: Codable, Hashable {
    let id: String
    let type: NotificationType
    let profilePictureURL: String
    let username: String
    let postID: String?
    let postImageURL: String?
    let isFollowing: Bool?
    let timestamp: String
}

enum NotificationType: Int, Codable, Hashable {
    case like = 0
    case `comment` = 1
    case follow = 2
}
