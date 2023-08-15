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
            HomeFeedCellType.poster(PosterCellViewModel(username: "jchoi", avatarImageURL: URL(string: "https://images.unsplash.com/photo-1636246441747-7d7f83f4629c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8MXx8fGVufDB8fHx8fA%3D%3D&w=1000&q=80")!)),
            HomeFeedCellType.post(PostCellViewModel(postImageURL: URL(string: "https://images.unsplash.com/photo-1636246441747-7d7f83f4629c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8MXx8fGVufDB8fHx8fA%3D%3D&w=1000&q=80")!)),
            HomeFeedCellType.actions(ActionsCellViewModel(isLiked: true)),
            HomeFeedCellType.likesCount(LikesCountCellViewModel(likers: [])),
            HomeFeedCellType.caption(CaptionCellViewModel(username: "jchoi", caption: "hello")),
            HomeFeedCellType.timestamp(TimeStampCellViewModel(date: Date())),
        ]])
    }
}
