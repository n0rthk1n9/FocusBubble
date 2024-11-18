//
//  MonthlyFocusTimeChartView.swift
//  FocusBubble
//
//  Created by Daniele Fontana on 18/11/24.
//

import Charts
import SwiftUI

struct MonthlyFocusTimeChartView: View {
    @Environment(\.timerManager) var timerManager
    @Environment(\.statisticsManager) var statisticsManager

    var body: some View {
        let monthlyFocusTime = statisticsManager.monthlyFocusTimeData

        Chart(monthlyFocusTime, id: \.month) { data in
            let monthIndex = statisticsManager.sortedMonths.firstIndex { $0 == data.month } ?? 0
            let currentMonth = statisticsManager.currentMonthIndex
            let barColor: Color =
                (monthIndex == currentMonth) ? timerManager.timerColor : timerManager.timerColor.opacity(0.6)

            BarMark(
                x: .value("Month", data.month),
                y: .value("Total Focus Time", data.totalFocusTime / 3600)  // Convert seconds to hours
            )
            .foregroundStyle(barColor)
        }
        .chartYAxisLabel("Hours")
    }
}

#Preview {
    MonthlyFocusTimeChartView()
        .environment(\.statisticsManager, StatisticsManager.mock)
        .aspectRatio(1, contentMode: .fit)
        .padding()
}
