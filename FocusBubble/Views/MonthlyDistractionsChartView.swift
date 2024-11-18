//
//  MonthlyDistractionsChartView.swift
//  FocusBubble
//
//  Created by Daniele Fontana on 18/11/24.
//

import SwiftUI
import Charts

struct MonthlyDistractionsChartView: View {
    let monthlyDistractions: [(month: String, totalDistractions: Int)]

    var body: some View {
        Chart(monthlyDistractions, id: \.month) { data in
            LineMark(
                x: .value("Month", data.month),
                y: .value("Distractions", data.totalDistractions)
            )
            .foregroundStyle(.red)
        }
        .chartYAxisLabel("Distractions")
    }
}

#Preview {
    MonthlyDistractionsChartView(
        monthlyDistractions: [("Jan", 5), ("Feb", 8), ("Mar", 3)]
    )
    .aspectRatio(1, contentMode: .fit)
    .padding()
}



