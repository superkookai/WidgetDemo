//
//  LogEntryAppIntent.swift
//  StreakWidgetExtension
//
//  Created by Weerawut Chaiyasomboon on 19/11/2568.
//

import Foundation
import AppIntents
import WidgetKit

struct LogEntryAppIntent: AppIntent {
    static var title: LocalizedStringResource = "Log entry to your Streak"
    
    static var description: IntentDescription? = "Add 1 to your Streak."
    
    func perform() async throws -> some IntentResult {
        let data = DataService()
        data.log()
        WidgetCenter.shared.reloadTimelines(ofKind: "StreakWidget")
        
        return .result(value: data.progress())
    }
}
