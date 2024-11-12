//
//  FocusBubbleApp.swift
//  FocusBubble
//
//  Created by Jan Armbrust on 12/11/24.
//

import SwiftUI

@main
struct FocusBubbleApp: App {
    @State private var timerObject = TimerObject()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(timerObject)
        }
    }
}
