//
//  ExploreViewModel.swift
//  Instagram
//
//  Created by Jung Choi on 8/22/23.
//

import Foundation

protocol ExploreViewModelDelegate: AnyObject {
    func exploreViewModelSearchCompleted(_ exploreViewModel: ExploreViewModel, _ users: [User])
}

class ExploreViewModel {
    
    weak var delegate: ExploreViewModelDelegate?
    private let userRepository: UserRepositoryProtocol
    private var users = [User]()
    
    init(userRepository: UserRepositoryProtocol) {
        self.userRepository = userRepository
    }
    
    func searchForUsers(with prefix: String) {
        userRepository.getUsers { [weak self] users in
            guard let self = self else { return }
            self.users = users.filter({ $0.username.lowercased().hasPrefix(prefix.lowercased()) })
            self.delegate?.exploreViewModelSearchCompleted(self, self.users)
        }
    }
}
