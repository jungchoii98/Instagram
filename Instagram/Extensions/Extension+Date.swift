//
//  Extension+Date.swift
//  Instagram
//
//  Created by Jung Choi on 8/21/23.
//

import Foundation

extension Date {
    static func string(from string: String) -> Date {
        guard let date = DateFormatter.formatter.date(from: string) else { return Date() }
        return date
    }
}
