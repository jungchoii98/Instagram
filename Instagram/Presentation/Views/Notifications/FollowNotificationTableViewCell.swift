//
//  FollowNotificationTableViewCell.swift
//  Instagram
//
//  Created by Jung Choi on 8/24/23.
//

import UIKit

class FollowNotificationTableViewCell: UITableViewCell {

    static let reuseID = "\(FollowNotificationTableViewCell.self)"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
