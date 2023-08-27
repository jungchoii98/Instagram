//
//  HomeFeedVCViewModel.swift
//  Instagram
//
//  Created by Jung Choi on 8/13/23.
//

import Foundation

protocol HomeFeedVCViewModelDelegate: AnyObject {
    func homeFeedVCViewModelDidFetchPosts(_ homeFeedVCViewModel: HomeFeedVCViewModel)
}

class HomeFeedVCViewModel {
    
    weak var delegate: HomeFeedVCViewModelDelegate?
    private let postRepository: PostRepositoryProtocol
    private let userRepository: UserRepositoryProtocol
    var posts = [[HomeFeedCellType]]()
    
    init(postRepository: PostRepositoryProtocol, userRepository: UserRepositoryProtocol) {
        self.postRepository = postRepository
        self.userRepository = userRepository
    }
    
    func fetchPosts() {
        guard let user = try? userRepository.getLoggedInUser() else { return }
        postRepository.fetchPosts(for: user.id) { [weak self] result in
            switch result {
            case .success(let posts):
                self?.configureCellViewModels(with: posts)
            case .failure(let error):
                print("Failed to fetch posts. Error: \(error.localizedDescription)")
            }
        }
//        posts.append(contentsOf: [
//            HomeFeedVCViewModel.cell1,
//            HomeFeedVCViewModel.cell2,
//        ])
    }
    
    private func configureCellViewModels(with posts: [Post]) {
        posts.forEach({ [weak self] post in
            guard let postImageURL = URL(string: post.postImageURL),
                  let avatarImageURL = URL(string: post.avatarImageURL)
            else { return }
            let posterCell = HomeFeedCellType.poster(PosterCellViewModel(username: post.username, avatarImageURL: avatarImageURL))
            let postCell = HomeFeedCellType.post(PostCellViewModel(postImageURL: postImageURL))
            let actionsCell = HomeFeedCellType.actions(ActionsCellViewModel(isLiked: !post.likers.isEmpty))
            let likesCountCell = HomeFeedCellType.likesCount(LikesCountCellViewModel(likers: post.likers))
            let captionCell = HomeFeedCellType.caption(CaptionCellViewModel(username: post.username, caption: post.caption))
            let timestampCell = HomeFeedCellType.timestamp(TimetampCellViewModel(date: Date.string(from: post.timestamp)))
            self?.posts.append([
                posterCell,
                postCell,
                actionsCell,
                likesCountCell,
                captionCell,
                timestampCell
            ])
        })
        delegate?.homeFeedVCViewModelDidFetchPosts(self)
    }
}

extension HomeFeedVCViewModel {
    static let cell1 = [
        HomeFeedCellType.poster(PosterCellViewModel(username: "chrchrane", avatarImageURL: URL(string: "https://www.allprodad.com/wp-content/uploads/2021/03/05-12-21-happy-people.jpg")!)),
        HomeFeedCellType.post(PostCellViewModel(postImageURL: URL(string: "https://images.unsplash.com/photo-1636246441747-7d7f83f4629c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8MXx8fGVufDB8fHx8fA%3D%3D&w=1000&q=80")!)),
        HomeFeedCellType.actions(ActionsCellViewModel(isLiked: true)),
        HomeFeedCellType.likesCount(LikesCountCellViewModel(likers: [
            "jbsmoodie",
            "jbsmoodie",
            "jbsmoodie",
            "jbsmoodie",
            "jbsmoodie",
            "jbsmoodie",
            "jbsmoodie",
            "jbsmoodie",
            "jbsmoodie",
            "jbsmoodie",
            "jbsmoodie",
            "jbsmoodie",
            "jbsmoodie",
            "jbsmoodie",
            "jbsmoodie",
            "jbsmoodie",
            "jbsmoodie",
            "jbsmoodie",
            "jbsmoodie",
            "jbsmoodie",
            "jbsmoodie",
        ])),
        HomeFeedCellType.caption(CaptionCellViewModel(username: "chrchrane", caption: "Majestic is an animal in the wild")),
        HomeFeedCellType.timestamp(TimetampCellViewModel(date: Date(timeIntervalSinceNow: 0))),
    ]
    static let cell2 = [
        HomeFeedCellType.poster(PosterCellViewModel(username: "tztanner", avatarImageURL: URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ8CldTqNpzN9ENCGC79zNXg6EfcqEHXTLjQg&usqp=CAU")!)),
        HomeFeedCellType.post(PostCellViewModel(postImageURL: URL(string: "https://img.freepik.com/free-photo/wide-angle-shot-single-tree-growing-clouded-sky-during-sunset-surrounded-by-grass_181624-22807.jpg?w=2000")!)),
        HomeFeedCellType.actions(ActionsCellViewModel(isLiked: true)),
        HomeFeedCellType.likesCount(LikesCountCellViewModel(likers: [
            "jbsmoodie",
            "jbsmoodie",
            "jbsmoodie",
            "jbsmoodie",
            "jbsmoodie",
            "jbsmoodie",
            "jbsmoodie",
            "jbsmoodie",
            "jbsmoodie",
            "jbsmoodie",
            "jbsmoodie",
            "jbsmoodie",
            "jbsmoodie",
            "jbsmoodie",
            "jbsmoodie",
            "jbsmoodie",
            "jbsmoodie",
            "jbsmoodie",
            "jbsmoodie",
            "jbsmoodie",
            "jbsmoodie",
            "jbsmoodie",
            "jbsmoodie",
            "jbsmoodie",
            "jbsmoodie",
            "jbsmoodie",
            "jbsmoodie",
            "jbsmoodie",
            "jbsmoodie",
            "jbsmoodie",
            "jbsmoodie",
            "jbsmoodie",
            "jbsmoodie",
            "jbsmoodie",
            "jbsmoodie",
            "jbsmoodie",
            "jbsmoodie",
            "jbsmoodie",
            "jbsmoodie",
            "jbsmoodie",
            "jbsmoodie",
            "jbsmoodie",
            "jbsmoodie",
        ])),
        HomeFeedCellType.caption(CaptionCellViewModel(username: "tztanner", caption: "Trees are the source of life")),
        HomeFeedCellType.timestamp(TimetampCellViewModel(date: Date(timeIntervalSinceNow: 0))),
    ]
}
