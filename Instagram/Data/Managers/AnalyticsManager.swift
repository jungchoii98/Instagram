//
//  AnalyticsManager.swift
//  Instagram
//
//  Created by Jung Choi on 7/26/23.
//

import FirebaseAnalytics
import Foundation

final class AnalyticsManager {
    
    static let shared = AnalyticsManager()
    
    private init() {}
    
    func logEvent() {
        FirebaseAnalytics.Analytics.logEvent("", parameters:[:])
    }
}
