//
//  ActionsCellViewModel.swift
//  Instagram
//
//  Created by Jung Choi on 8/13/23.
//

import Foundation

struct ActionsCellViewModel: Hashable {
    
    let uuid = UUID()
    let isLiked: Bool
}

extension ActionsCellViewModel {
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
}
