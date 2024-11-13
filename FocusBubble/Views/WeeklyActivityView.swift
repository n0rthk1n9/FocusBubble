//
//  WeeklyActivityView.swift
//  FocusBubble
//
//  Created by Daniele Fontana on 13/11/24.
//

import SwiftUI

struct WeeklyActivityView: View {
    var dailyHours: [String: Double] // Dictionary per memorizzare le ore giornaliere

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Weekly Activity")
                .font(.title2)
                .fontWeight(.semibold)

            Spacer().frame(height: 5)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 25) {
                    ForEach(dailyHours.keys.sorted(), id: \.self) { day in
                        VStack {
                            ZStack(alignment: .center) {
                                Circle()
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 8)
                                    .frame(width: 70, height: 80)
                                Circle()
                                    .trim(from: 0, to: CGFloat(min(dailyHours[day] ?? 0, 24)) / 24)
                                    .stroke(Color.blue, lineWidth: 8)
                                    .rotationEffect(.degrees(-90))
                                    .frame(width: 70, height: 70)

                                Text("\(Int(dailyHours[day] ?? 0))h")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .foregroundColor(.blue)
                            }
                            Text(day)
                                .font(.headline)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white)
                .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 5)
        )
    }
}

#Preview {
    WeeklyActivityView(dailyHours: ["Mon": 1, "Tue": 2, "Wed": 1.5, "Thu": 3, "Fri": 2, "Sat": 1, "Sun": 2.5])
}
