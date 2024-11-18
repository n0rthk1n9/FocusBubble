//
//  StatisticsView.swift
//  FocusBubble
//
//  Created by Jan Armbrust on 12/11/24.
//

import SwiftUI

struct StatisticsView: View {
    @Environment(\.statisticsManager) var model

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    Text("Today you've been focused for")
                        .font(.body)
                        .foregroundColor(Color.gray)
                        .padding(.leading, -132)

                    
                    VStack(spacing: 10) {
                        BubbleAnimationView(imageName: "Bubble100")
                            .frame(width: 140, height: 140)
                        Text("4.5h")
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                            .padding(.top, -10)
                        Text("Excellent Focus")
                            .foregroundColor(.gray)
                            .padding(.bottom, 15)
                    }

                    VStack(alignment: .leading, spacing: 10) {
                        Text("Monthly Focus Time")
                            .font(.title2)
                            .fontWeight(.semibold)

                        MonthlyFocusTimeChartView(
                            monthlyFocusTime: model.monthlyFocusTimeData
                        )
                        .frame(height: 300)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.white)
                            .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 5)
                    )
                    .padding(.horizontal)

                    VStack(alignment: .leading, spacing: 10) {
                        Text("Monthly Distractions")
                            .font(.title2)
                            .fontWeight(.semibold)

                        MonthlyDistractionsChartView(
                            monthlyDistractions: model.monthlyDistractionsData
                        )
                        .frame(height: 300)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.white)
                            .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 5)
                    )
                    .padding(.horizontal)
                }
                .navigationTitle("Your Analytics")
                .onAppear {
                    model.updateData(
                        focusSessions: [
                            FocusSession(date: Date(), focusTime: 3600, distractions: 1),
                            FocusSession(date: Date().addingTimeInterval(-86400 * 30), focusTime: 4200, distractions: 2),
                            FocusSession(date: Date().addingTimeInterval(-86400 * 60), focusTime: 4800, distractions: 3),
                            FocusSession(date: Date().addingTimeInterval(-86400 * 90), focusTime: 5400, distractions: 4),
                            FocusSession(date: Date().addingTimeInterval(-86400 * 120), focusTime: 6000, distractions: 1),
                            FocusSession(date: Date().addingTimeInterval(-86400 * 150), focusTime: 6600, distractions: 2),
                            FocusSession(date: Date().addingTimeInterval(-86400 * 180), focusTime: 7200, distractions: 3),
                            FocusSession(date: Date().addingTimeInterval(-86400 * 210), focusTime: 7800, distractions: 4),
                            FocusSession(date: Date().addingTimeInterval(-86400 * 240), focusTime: 8400, distractions: 1),
                            FocusSession(date: Date().addingTimeInterval(-86400 * 270), focusTime: 9000, distractions: 2),
                            FocusSession(date: Date().addingTimeInterval(-86400 * 300), focusTime: 9600, distractions: 3),
                            FocusSession(date: Date().addingTimeInterval(-86400 * 330), focusTime: 10200, distractions: 4)
                        ]
                    )
                }
            }
        }
    }
}

#Preview {
    StatisticsView()
}
