//
//  StreakWidget.swift
//  StreakWidget
//
//  Created by Weerawut Chaiyasomboon on 19/11/2568.
//

import WidgetKit
import SwiftUI
import AppIntents

struct Provider: TimelineProvider {
    let data = DataService()
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), streak: data.progress())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), streak: data.progress())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, streak: data.progress())
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }

//    func relevances() async -> WidgetRelevances<Void> {
//        // Generate a list containing the contexts this widget is relevant in.
//    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let streak: Int
}

struct StreakWidgetEntryView : View {
    var entry: Provider.Entry
    let data = DataService()
    
    @Environment(\.widgetFamily) private var family

    var body: some View {
        switch family {
        case .systemSmall:
            SmallStreakView(streak: entry.streak)
        case .systemMedium:
            MediumStreakView(streak: entry.streak)
        default:
            SmallStreakView(streak: entry.streak)
        }
    }
}

struct SmallStreakView: View {
    let streak: Int
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(.gray.opacity(0.1), lineWidth: 18)
            
            let progress = Double(streak)/50.0
            Circle()
                .trim(from: 0, to: progress)
                .stroke(.blue, style: StrokeStyle(lineWidth: 18, lineCap: .round, lineJoin: .round))
                .rotationEffect(.degrees(-90))
            
            VStack(spacing: 0) {
                Text("\(streak)")
                    .font(.title3)
                    .bold()
                    .fontDesign(.rounded)
                Button(intent: LogEntryAppIntent()) {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

struct MediumStreakView: View {
    let streak: Int
    
    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .stroke(.gray.opacity(0.1), lineWidth: 18)
                
                let progress = Double(streak)/50.0
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(.blue, style: StrokeStyle(lineWidth: 18, lineCap: .round, lineJoin: .round))
                    .rotationEffect(.degrees(-90))
                
                VStack(spacing: 0) {
                    Text("\(streak)")
                        .font(.title3)
                        .bold()
                        .fontDesign(.rounded)
                }
            }
            
            Spacer()
            
            VStack {
                Text("This is on Medium!!")
                Button(intent: LogEntryAppIntent()) {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

struct StreakWidget: Widget {
    let kind: String = "StreakWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                StreakWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
                    
            } else {
                StreakWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemSmall,.systemMedium])
    }
}

#Preview(as: .systemSmall) {
    StreakWidget()
} timeline: {
    SimpleEntry(date: .now, streak: 10)
}

#Preview(as: .systemMedium) {
    StreakWidget()
} timeline: {
    SimpleEntry(date: .now, streak: 10)
}
