//
//  FocusBubbleApp.swift
//  FocusBubble
//
//  Created by Jan Armbrust on 12/11/24.
//

import SwiftUI

@main
struct FocusBubbleApp: App {
    @State private var timerManager = TimerManager()
    @State private var statisticsModel = StatisticsManager()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.timerManager, timerManager)
                .environment(\.statisticsManager, statisticsModel)
                .tint(timerManager.timerColor)
        }
    }
}
