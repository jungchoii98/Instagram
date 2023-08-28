//
//  Extension+DateFormatter.swift
//  Instagram
//
//  Created by Jung Choi on 8/15/23.
//

import Foundation

extension DateFormatter {
    static var formatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }
}

extension RelativeDateTimeFormatter {
    static var relativeFormatter: RelativeDateTimeFormatter {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .short
        return formatter
    }
}
