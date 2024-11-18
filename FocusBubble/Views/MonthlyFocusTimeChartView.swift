//
//  MonthlyFocusTimeChartView.swift
//  FocusBubble
//
//  Created by Daniele Fontana on 18/11/24.
//

import SwiftUI
import Charts

struct MonthlyFocusTimeChartView: View {
    let monthlyFocusTime: [(month: String, totalFocusTime: TimeInterval)]

    var body: some View {
        Chart(monthlyFocusTime, id: \.month) { data in
            BarMark(
                x: .value("Month", data.month),
                y: .value("Total Focus Time", data.totalFocusTime / 3600) // Convert to hours
            )
            .foregroundStyle(.blue)
        }
        .chartYAxisLabel("Hours")
    }
}

#Preview {
    MonthlyFocusTimeChartView(
        monthlyFocusTime: [("Jan", 7200), ("Feb", 10800), ("Mar", 5400)]
    )
    .aspectRatio(1, contentMode: .fit)
    .padding()
}



