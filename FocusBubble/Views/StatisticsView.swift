//
//  StatisticsView.swift
//  FocusBubble
//
//  Created by Jan Armbrust on 12/11/24.
//

import SwiftUI

struct StatisticsView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                HStack {
                    Text("Today")
                        .font(.title2)
                        .foregroundColor(.gray)
                    Spacer()
                }
                .padding(.horizontal)

                VStack {
                    ZStack {
                        Circle()
                            .fill(LinearGradient(gradient: Gradient(colors: [Color.purple.opacity(0.5), Color.blue.opacity(0.5)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                            .frame(width: 120, height: 120)
                    }
                    Text("4.5h")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                    Text("Excellent Focus")
                        .foregroundColor(.gray)
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

                    GeometryReader { geometry in
                        Path { path in
                            path.move(to: CGPoint(x: 0, y: geometry.size.height))
                            path.addCurve(to: CGPoint(x: geometry.size.width, y: geometry.size.height * 0.7),
                                          control1: CGPoint(x: geometry.size.width * 0.25, y: geometry.size.height * 0.4),
                                          control2: CGPoint(x: geometry.size.width * 0.75, y: geometry.size.height * 0.3))
                        }
                        .stroke(Color.blue, lineWidth: 2)
                    }
                    .frame(height: 100)
                    .padding(.vertical, 10)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.white)
                        .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 5)
                )
                .padding(.horizontal)

                VStack(alignment: .leading, spacing: 10) {
                    Text("Weekly Activity")
                        .font(.title2)
                        .fontWeight(.semibold)

                    Spacer().frame(height: 5)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 25) {
                            ForEach(["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"], id: \.self) { day in
                                VStack {
                                    ZStack(alignment: .center) {
                                        Circle()
                                            .stroke(Color.gray.opacity(0.3), lineWidth: 8)
                                            .frame(width: 70, height: 80)
                                        Circle()
                                            .trim(from: 0, to: 0.1)
                                            .stroke(Color.blue, lineWidth: 8)
                                            .rotationEffect(.degrees(-90))
                                            .frame(width: 70, height: 70)

                                        Text("1h")
                                            .font(.headline)
                                            .fontWeight(.bold)
                                            .foregroundColor(.blue)
                                    }
                                    Text(day)
                                        .font(.headline)
                                        .padding(.top, 5)
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
                .padding(.horizontal)
            }
            .navigationTitle("Your Analytics")
        }
    }
}

#Preview {
    StatisticsView()
}
