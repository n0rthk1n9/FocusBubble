//
//  MonthlyDistractionsChartView.swift
//  FocusBubble
//
//  Created by Daniele Fontana on 18/11/24.
//

import SwiftUI
import Charts

struct MonthlyDistractionsChartView: View {
    @Environment(\.timerManager) var timerManager
    @Environment(\.statisticsManager) var statisticsManager

    var body: some View {
        let monthlyDistractions = statisticsManager.monthlyDistractionsData

        Chart(monthlyDistractions, id: \.month) { data in
            LineMark(
                x: .value("Month", data.month),
                y: .value("Distractions", data.totalDistractions)
            )
            .foregroundStyle(timerManager.timerColor)
        }
        .chartYAxisLabel("Distractions")
    }
}

#Preview {
    MonthlyDistractionsChartView()
        .environment(\.statisticsManager, StatisticsManager.mock)
            .aspectRatio(1, contentMode: .fit)
            .padding()
}



