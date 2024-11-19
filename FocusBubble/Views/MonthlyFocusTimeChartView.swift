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
    @State var statisticsManager = StatisticsManager.mock

    var body: some View {
        let monthlyFocusTime = statisticsManager.monthlyFocusTimeData
        let sortedMonths = statisticsManager.sortedMonths

        let currentMonthName = Calendar.current.shortMonthSymbols[statisticsManager.currentMonthIndex]
        let currentSortedIndex = sortedMonths.firstIndex(of: currentMonthName) ?? 0

        Chart(monthlyFocusTime, id: \.month) { data in
            let monthIndex = sortedMonths.firstIndex(of: data.month) ?? 0
            let barColor: Color =
                (monthIndex == currentSortedIndex) ? timerManager.timerColor : timerManager.timerColor.opacity(0.6)

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

