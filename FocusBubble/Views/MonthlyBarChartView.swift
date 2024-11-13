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
        let maxHours = model.hoursPerMonth.max() ?? 1  // Calcolare il massimo valore delle ore
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .bottom, spacing: 15) {
                ForEach(0..<model.months.count, id: \.self) { index in
                    VStack {
                        // Mostra il numero delle ore sopra la barra
                        Text("\(model.hoursPerMonth[index])h")
                            .font(.caption)
                            .foregroundColor(.blue)
                            .padding(.bottom, 2)  // Piccola spaziatura tra le ore e bubbles popped

                        // Mostra il numero di "bubbles popped" sotto il numero delle ore
                        Text("\(model.bubblesPoppedPerMonth[index])")
                            .font(.caption)
                            .foregroundColor(.red)
                            .padding(.bottom, 5)  // Spaziatura tra il numero di bubbles popped e la barra

                        // Barra delle ore
                        ZStack {
                            RoundedRectangle(cornerRadius: 5)
                                .fill(Color.blue)
                                .frame(width: 20, height: CGFloat(model.hoursPerMonth[index]) / CGFloat(maxHours) * 100)
                        }

                        // Mostra il nome del mese sotto la barra
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

