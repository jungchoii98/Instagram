//
//  Extension+String.swift
//  Instagram
//
//  Created by Jung Choi on 8/15/23.
//

import Foundation

extension String {
    static func date(from date: Date) -> String {
        return DateFormatter.formatter.string(from: date)
    }
    
    static func timeAgo(dateString: String) -> String {
        let date = Date.string(from: dateString)
        return RelativeDateTimeFormatter.relativeFormatter.localizedString(for: date, relativeTo: Date())
    }
}
