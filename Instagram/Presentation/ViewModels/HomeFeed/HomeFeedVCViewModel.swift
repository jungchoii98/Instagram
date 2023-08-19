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
        posts.append(contentsOf: [
            [
                HomeFeedCellType.poster(PosterCellViewModel(username: "chrchrane", avatarImageURL: URL(string: "https://www.allprodad.com/wp-content/uploads/2021/03/05-12-21-happy-people.jpg")!)),
                HomeFeedCellType.post(PostCellViewModel(postImageURL: URL(string: "https://images.unsplash.com/photo-1636246441747-7d7f83f4629c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8MXx8fGVufDB8fHx8fA%3D%3D&w=1000&q=80")!)),
                HomeFeedCellType.actions(ActionsCellViewModel(isLiked: true)),
                HomeFeedCellType.likesCount(LikesCountCellViewModel(likers: ["jbsmoodie"])),
                HomeFeedCellType.caption(CaptionCellViewModel(username: "chrchrane", caption: "Majestic is an animal in the wild")),
                HomeFeedCellType.timestamp(TimetampCellViewModel(date: Date(timeIntervalSinceNow: 0))),
            ],
            [
                HomeFeedCellType.poster(PosterCellViewModel(username: "tztanner", avatarImageURL: URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ8CldTqNpzN9ENCGC79zNXg6EfcqEHXTLjQg&usqp=CAU")!)),
                HomeFeedCellType.post(PostCellViewModel(postImageURL: URL(string: "https://img.freepik.com/free-photo/wide-angle-shot-single-tree-growing-clouded-sky-during-sunset-surrounded-by-grass_181624-22807.jpg?w=2000")!)),
                HomeFeedCellType.actions(ActionsCellViewModel(isLiked: true)),
                HomeFeedCellType.likesCount(LikesCountCellViewModel(likers: ["jbsmoodie"])),
                HomeFeedCellType.caption(CaptionCellViewModel(username: "tztanner", caption: "Trees are the source of life")),
                HomeFeedCellType.timestamp(TimetampCellViewModel(date: Date(timeIntervalSinceNow: 0))),
            ],
        ])
    }
}
