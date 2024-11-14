//
//  StatisticsView.swift
//  FocusBubble
//
//  Created by Jan Armbrust on 12/11/24.
//

import SwiftUI

struct StatisticsView: View {
    @StateObject private var model = StatisticsModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 2) {
                HStack {
                    Text("Today")
                        .font(.title2)
                        .foregroundColor(.gray)
                    Spacer()
                }
                .padding(.horizontal)

                VStack(spacing: -10) {
                    BubbleAnimationView(imageName: "Bubble100")
                        .frame(width: 140, height: 140)

                    Text("4.5h")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .padding(.bottom, 3)
                    Text("Excellent Focus")
                        .foregroundColor(.gray)
                        .padding(.bottom, 10)
                }

                VStack(alignment: .leading, spacing: 10) {
                    Text("Monthly Activity")
                        .font(.title2)
                        .fontWeight(.semibold)

                    HStack {
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 10, height: 10)
                        Text("Active Session")
                            .font(.caption)

                        Circle()
                            .fill(Color.red)
                            .frame(width: 10, height: 10)
                        Text("Popped Bubbles")
                            .font(.caption)
                    }

                    MonthlyBarChartView(model: model)
                        .frame(height: 150)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.white)
                        .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 5)
                )
                .padding(.horizontal)

                WeeklyActivityView(dailyHours: $model.dailyHours)
                    .padding(.horizontal)
            }
            .navigationTitle("Your Analytics")
            .onAppear {
                model.updateData(
                    hours: [12, 14, 16, 10, 9, 8, 10, 13, 15, 18, 19, 25],
                    bubbles: [1, 3, 2, 1, 2, 1, 0, 1, 0, 0, 1, 1],
                    dailyHours: ["Mon": 1, "Tue": 2, "Wed": 1.5, "Thu": 3, "Fri": 2, "Sat": 1, "Sun": 2.5]
                )
            }
        }
    }
}

#Preview {
    StatisticsView()
}
