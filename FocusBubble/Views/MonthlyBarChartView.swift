//
//  MonthlyBarChartView.swift
//  FocusBubble
//
//  Created by Daniele Fontana on 13/11/24.
//

import SwiftUI

struct MonthlyBarChartView: View {
    @ObservedObject var model: StatisticsModel

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .bottom, spacing: 15) {
                ForEach(0..<model.months.count, id: \.self) { index in
                    VStack {
                        Text("\(model.hoursPerMonth[index])h")
                            .font(.caption)
                            .foregroundColor(.blue)
                            .padding(.bottom, 5)

                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color.blue)
                            .frame(width: 20, height: CGFloat(model.hoursPerMonth[index]) * 4)
                        
                        Text(model.months[index])
                            .font(.caption)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    MonthlyBarChartView(model: StatisticsModel())
}

