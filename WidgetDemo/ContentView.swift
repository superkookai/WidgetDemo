//
//  ContentView.swift
//  WidgetDemo
//
//  Created by Weerawut Chaiyasomboon on 19/11/2568.
//

import SwiftUI
import WidgetKit

struct ContentView: View {
    @AppStorage("Streak", store: UserDefaults(suiteName: "group.com.superkookai.widgetdemo")) var streak = 0
    
    let max: Double = 50
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .stroke(.regularMaterial, lineWidth: 30)
                
                
                let progress = Double(streak)/max
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(.blue, style: StrokeStyle(lineWidth: 30, lineCap: .round, lineJoin: .round))
                    .rotationEffect(.degrees(-90))
                
                VStack {
                    Text("STREAKS")
                    
                    Text("\(streak)")
                        .font(.system(size: 50))
                        .bold()
                        .padding()
                        .background(.regularMaterial,in: .rect(corners: .fixed(10)))
                        .padding(.bottom)
                }
                .fontDesign(.rounded)
            }
            .padding(40)
            
            Button {
                if streak <= 50 {
                    streak += 1
                    WidgetCenter.shared.reloadTimelines(ofKind: "StreakWidget")
                }
            } label: {
                Image(systemName: "plus.circle.fill")
            }
            .font(.system(size: 50))

        }
    }
}

#Preview {
    ContentView()
}
