//
//  CaptionVCViewModel.swift
//  Instagram
//
//  Created by Jung Choi on 8/19/23.
//

import Foundation

protocol CaptionVCViewModelDelegate: AnyObject {
    func captionVCViewModelDidFailToPost(_ captionVCViewModel: CaptionVCViewModel)
    func captionVCViewModelDidSucceedToPost(_ captionVCViewModel: CaptionVCViewModel)
}

class CaptionVCViewModel {
    
    weak var delegate: CaptionVCViewModelDelegate?
    private let postRepository: PostRepositoryProtocol
    private let user: User
    
    init(postRepository: PostRepositoryProtocol, user: User) {
        self.postRepository = postRepository
        self.user = user
    }
    
    func createPost(pictureData: Data?, caption: String) {
        createPost(username: user.username, profileImageURL: user.profileImageURL, pictureData: pictureData, caption: caption)
    }
    
    private func createPost(username: String, profileImageURL: String, pictureData: Data?, caption: String) {
        postRepository.storePost(username: username, postID: UUID().uuidString, pictureData: pictureData) { [weak self] url in
            guard let self = self else { return }
            guard let url = url else {
                self.delegate?.captionVCViewModelDidFailToPost(self)
                return
            }
            let post = Post(username: username, avatarImageURL: profileImageURL, postImageURL: url.absoluteString, likers: [], caption: caption, timestamp: String.date(from: Date()))
            self.postRepository.uploadPost(username: username, post: post) { [weak self] didSucceed in
                guard let self = self else { return }
                if didSucceed {
                    self.delegate?.captionVCViewModelDidSucceedToPost(self)
                } else {
                    self.delegate?.captionVCViewModelDidFailToPost(self)
                }
            }
        }
    }
}
