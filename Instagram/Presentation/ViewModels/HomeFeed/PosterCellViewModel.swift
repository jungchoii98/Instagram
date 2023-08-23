//
//  PosterCellViewModel.swift
//  Instagram
//
//  Created by Jung Choi on 8/13/23.
//

import Foundation

struct PosterCellViewModel: Hashable {
    let uuid = UUID()
    let username: String
    let avatarImageURL: URL
}
