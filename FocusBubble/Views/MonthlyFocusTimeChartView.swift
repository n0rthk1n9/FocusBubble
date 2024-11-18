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
   
        let shortMonthSymbols = Calendar.current.shortMonthSymbols

        let currentMonth = Calendar.current.component(.month, from: Date()) - 1

        Chart(monthlyFocusTime, id: \.month) { data in

            let monthIndex = shortMonthSymbols.firstIndex { $0 == data.month } ?? 0
            
    
            let barColor: Color = (monthIndex == currentMonth) ? .blue : .blue.opacity(0.6)

            BarMark(
                x: .value("Month", data.month),
                y: .value("Total Focus Time", data.totalFocusTime / 3600)
            )
            .foregroundStyle(barColor)
        }
        .chartYAxisLabel("Hours")
    }
}

#Preview {
    MonthlyFocusTimeChartView(
        monthlyFocusTime: [("Jan", 7200), ("Feb", 10800), ("Mar", 5400), ("Nov", 10000)]
    )
    .aspectRatio(1, contentMode: .fit)
    .padding()
}





