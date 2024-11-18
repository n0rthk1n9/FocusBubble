//
//  EnvironmentValues+Extension.swift
//  FocusBubble
//
//  Created by Jan Armbrust on 15/11/24.
//

import SwiftUI

extension EnvironmentValues {
    var timerManager: TimerManager {
        get { self[TimerManagerEnvironmentKey.self] }
        set { self[TimerManagerEnvironmentKey.self] = newValue }
    }

    var statisticsManager: StatisticsManager {
        get { self[StatisticsManagerEnvironmentKey.self] }
        set { self[StatisticsManagerEnvironmentKey.self] = newValue }
    }
    
    
}

