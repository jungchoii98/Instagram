//
//  ExploreViewModel.swift
//  Instagram
//
//  Created by Jung Choi on 8/22/23.
//

import Foundation

protocol ExploreViewModelDelegate: AnyObject {
    func exploreViewModelSearchCompleted(_ exploreViewModel: ExploreViewModel, _ users: [User])
    func exploreViewModelFetchedAllPosts(_ exploreViewModel: ExploreViewModel, _ posts: [Post])
}

class ExploreViewModel {
    
    weak var delegate: ExploreViewModelDelegate?
    private let userRepository: UserRepositoryProtocol
    private let postRepository: PostRepositoryProtocol
    
    init(userRepository: UserRepositoryProtocol, postRepository: PostRepositoryProtocol) {
        self.userRepository = userRepository
        self.postRepository = postRepository
    }
    
    func searchForUsers(with prefix: String) {
        userRepository.getUsers { [weak self] users in
            guard let self = self else { return }
            let users = users.filter({ $0.username.lowercased().hasPrefix(prefix.lowercased()) })
            self.delegate?.exploreViewModelSearchCompleted(self, users)
        }
    }
    
    func fetchAllPosts() {
        postRepository.fetchAllPosts { [weak self] posts in
            guard let self = self else { return }
            self.delegate?.exploreViewModelFetchedAllPosts(self, posts)
        }
    }
}

extension ExploreViewModel {
    static let postsStub = [
        Post(id: "1", userID: UUID().uuidString, username: "", avatarImageURL: "", postImageURL: "https://www.allprodad.com/wp-content/uploads/2021/03/05-12-21-happy-people.jpg", likers: [], caption: "", timestamp: ""),
        Post(id: "2", userID: UUID().uuidString, username: "", avatarImageURL: "", postImageURL: "https://images.unsplash.com/photo-1636246441747-7d7f83f4629c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8MXx8fGVufDB8fHx8fA%3D%3D&w=1000&q=80", likers: [], caption: "", timestamp: ""),
        Post(id: "3", userID: UUID().uuidString, username: "", avatarImageURL: "", postImageURL: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ8CldTqNpzN9ENCGC79zNXg6EfcqEHXTLjQg&usqp=CAU", likers: [], caption: "", timestamp: ""),
        Post(id: "4", userID: UUID().uuidString, username: "", avatarImageURL: "", postImageURL: "https://img.freepik.com/free-photo/wide-angle-shot-single-tree-growing-clouded-sky-during-sunset-surrounded-by-grass_181624-22807.jpg?w=2000", likers: [], caption: "", timestamp: ""),
        Post(id: "5", userID: UUID().uuidString, username: "", avatarImageURL: "", postImageURL: "https://www.alleycat.org/wp-content/uploads/2019/03/FELV-cat.jpg", likers: [], caption: "", timestamp: ""),
        Post(id: "6", userID: UUID().uuidString, username: "", avatarImageURL: "", postImageURL: "https://cdn.britannica.com/39/7139-050-A88818BB/Himalayan-chocolate-point.jpg", likers: [], caption: "", timestamp: "")
    ]
}
