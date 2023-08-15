//
//  TimetampCellViewModel.swift
//  Instagram
//
//  Created by Jung Choi on 8/13/23.
//

import Foundation

struct TimetampCellViewModel: Hashable {
    
    private let date: Date
    
    init(date: Date) {
        self.date = date
    }
    
    func getTimestamp() -> String {
        return String.date(from: date)
    }
}
