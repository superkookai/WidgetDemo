//
//  DataService.swift
//  StreakWidgetExtension
//
//  Created by Weerawut Chaiyasomboon on 19/11/2568.
//

import Foundation
import SwiftUI

struct DataService {
    @AppStorage("Streak", store: UserDefaults(suiteName: "group.com.superkookai.widgetdemo"))
    private var streak = 0
    
    func log() {
        streak += 1
    }
    
    func progress() -> Int {
        streak
    }
}
