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
            VStack(spacing: 10) {
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

                    MonthlyBarChartView(model: model) // Passa il modello qui
                        .frame(height: 150)
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
            .onAppear {
                
                // Esempio di aggiornamento dei dati
                model.updateData(hours: [12, 14, 16, 10, 9, 8, 10, 13, 15, 18, 19, 25], bubbles: [1, 3, 2, 1, 2, 1, 0, 1, 0, 0, 1, 1])

                
            }
        }
    }
}

#Preview {
    StatisticsView()
}
