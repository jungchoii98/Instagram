//
//  LikesCountCellViewModel.swift
//  Instagram
//
//  Created by Jung Choi on 8/13/23.
//

import Foundation

struct LikesCountCellViewModel: Hashable {
    
    let uuid = UUID()
    let likers: [String]
}

extension LikesCountCellViewModel {
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
}
