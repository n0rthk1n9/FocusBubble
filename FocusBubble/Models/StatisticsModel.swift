//
//  StatisticsModel.swift
//  FocusBubble
//
//  Created by Daniele Fontana on 13/11/24.
//

import SwiftUI
import Combine

class StatisticsModel: ObservableObject {
    @Published var months: [String]
    @Published var hoursPerMonth: [Int]

    init() {
        // default values
        self.months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        self.hoursPerMonth = [15, 18, 12, 20, 10, 16, 21, 14, 22, 11, 9, 19]
    }

    func updateData(newHoursPerMonth: [Int]) {
        guard newHoursPerMonth.count == months.count else {
            print("Errore: il numero di valori non corrisponde ai mesi.")
            return
        }
        self.hoursPerMonth = newHoursPerMonth
    }
}
