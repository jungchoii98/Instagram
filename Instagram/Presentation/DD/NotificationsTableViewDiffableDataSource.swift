//
//  NotificationsTableViewDiffableDataSource.swift
//  Instagram
//
//  Created by Jung Choi on 8/26/23.
//

import UIKit

class NotificationsTableViewDiffableDataSource<Section: Hashable & Sendable, Item: Hashable & Sendable>: UITableViewDiffableDataSource<Section, Item> {
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var header = ""
        switch section {
        case 0:
            header = "This Week"
        case 1:
            header = "This Month"
        default:
            header = "Earlier"
        }
        return header
    }
}
