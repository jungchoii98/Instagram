//
//  HomeFeedVCViewModel.swift
//  Instagram
//
//  Created by Jung Choi on 8/13/23.
//

import Foundation

struct HomeFeedVCViewModel {
    
    var posts = [[HomeFeedCellType]]()
    
    mutating func fetchPosts() {
        posts.append(contentsOf: [[
            HomeFeedCellType.poster(PosterCellViewModel(username: "jchoi", avatarImageURL: "")),
            HomeFeedCellType.post(PostCellViewModel(postImageURL: "")),
            HomeFeedCellType.actions(ActionsCellViewModel(isLiked: true)),
            HomeFeedCellType.likesCount(LikesCountCellViewModel(likers: [])),
            HomeFeedCellType.caption(CaptionCellViewModel(username: "jchoi", caption: "hello")),
            HomeFeedCellType.timestamp(TimeStampCellViewModel(date: Date())),
        ]])
    }
}
