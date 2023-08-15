//
//  HelperModels.swift
//  Instagram
//
//  Created by Jung Choi on 8/13/23.
//

import Foundation

enum HomeFeedCellType: Hashable {
    case poster(PosterCellViewModel)
    case post(PostCellViewModel)
    case actions(ActionsCellViewModel)
    case likesCount(LikesCountCellViewModel)
    case caption(CaptionCellViewModel)
    case timestamp(TimetampCellViewModel)
}
