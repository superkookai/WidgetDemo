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

/*
 Use AppIntent and Deeplink to open specific screen in your App
 
 struct OpenItemIntent: OpenIntent {
 static var title: LocalizedStringResource = "Open Item"
 @Parameter(title: "Item ID") var itemID: String
 
 func perform() async throws -> some IntentResult & OpensIntent {
 // Return a destination in your app
 // For SwiftUI lifecycle, use Scene-bound routing or onOpenURL:
 return .result(opensIntent: self)
 }
 }
 
 //Also see DeepLink from YouTube
 Link(value: OpenItemIntent(itemID: entry.itemID)) {
 Label("Open", systemImage: "arrow.forward.circle")
 }
 */
