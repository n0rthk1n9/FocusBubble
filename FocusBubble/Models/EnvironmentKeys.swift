//
//  EnvironmentKeys.swift
//  FocusBubble
//
//  Created by Jan Armbrust on 15/11/24.
//

import SwiftUI

struct TimerManagerEnvironmentKey: EnvironmentKey {
    static let defaultValue: TimerManager = TimerManager()
}

struct StatisticsManagerEnvironmentKey: EnvironmentKey {
    static let defaultValue: StatisticsManager = StatisticsManager()
}
