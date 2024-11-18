//
//  StatisticsView.swift
//  FocusBubble
//
//  Created by Jan Armbrust on 12/11/24.
//

import SwiftUI

struct StatisticsView: View {
    @Environment(\.statisticsManager) var statisticsManager
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Today you've been focused for")
                        .font(.body)
                        .foregroundColor(Color.gray)

                    VStack(spacing: 10) {
                        BubbleAnimationView(imageName: "Bubble100")
                            .frame(width: 140, height: 140)
                        Text("2h 25m")
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                        Text("Excellent Focus")
                            .foregroundColor(.gray)
                            .padding(.bottom)
                    }
                    .frame(maxWidth: .infinity)

                    VStack(alignment: .leading, spacing: 10) {
                        Text("Monthly Focus Time")
                            .font(.title2)
                            .fontWeight(.semibold)

                        MonthlyFocusTimeChartView()
                            .frame(height: 180)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(colorScheme == .light ? .white : .gray.opacity(0.3))
                            .shadow(color: colorScheme == .light ? .gray.opacity(0.3) : .white.opacity(0.1), radius: 5, x: 0, y: 5)
                    )

                    VStack(alignment: .leading, spacing: 10) {
                        Text("Monthly Distractions")
                            .font(.title2)
                            .fontWeight(.semibold)

                        MonthlyDistractionsChartView()
                            .frame(height: 180)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(colorScheme == .light ? .white : .gray.opacity(0.3))
                            .shadow(color: colorScheme == .light ? .gray.opacity(0.3) : .white.opacity(0.1), radius: 5, x: 0, y: 5)
                    )
                }
                .padding(.horizontal)
                .navigationTitle("Your Analytics")
            }
        }
    }

    private func formattedTime(_ time: TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = (Int(time) % 3600) / 60
        return "\(hours)h \(minutes)m"
    }
}

#Preview {
    StatisticsView()
        .environment(\.statisticsManager, StatisticsManager.mock)
}
