//
//  StatisticsManager.swift
//  FocusBubble
//
//  Created by Daniele Fontana on 13/11/24.
//

import SwiftUI

@Observable
class StatisticsManager {
    var focusSessions: [FocusSession]

    init(focusSessions: [FocusSession] = []) {
        self.focusSessions = focusSessions
    }

    var monthlyFocusTimeData: [(month: String, totalFocusTime: TimeInterval)] {
        let grouped = Dictionary(grouping: focusSessions) { session in
            Calendar.current.dateComponents([.year, .month], from: session.date)
        }

        let shortMonthSymbols = Calendar.current.shortMonthSymbols

        let currentMonthIndex = Calendar.current.component(.month, from: Date()) - 1


        let sortedMonths = Array(shortMonthSymbols[(currentMonthIndex+1)...]) + Array(shortMonthSymbols[0...(currentMonthIndex)])

  
        return grouped.map { key, value in
            let totalFocusTime = value.reduce(0) { $0 + $1.focusTime }
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM"
            let monthString = dateFormatter.string(from: Calendar.current.date(from: key)!)
            return (monthString, totalFocusTime)
        }
        .sorted { first, second in
            sortedMonths.firstIndex(of: first.month)! < sortedMonths.firstIndex(of: second.month)!
        }
    }

    var monthlyDistractionsData: [(month: String, totalDistractions: Int)] {
        let grouped = Dictionary(grouping: focusSessions) { session in
            Calendar.current.dateComponents([.year, .month], from: session.date)
        }


        let shortMonthSymbols = Calendar.current.shortMonthSymbols


        let currentMonthIndex = Calendar.current.component(.month, from: Date()) - 1

        let sortedMonths = Array(shortMonthSymbols[(currentMonthIndex+1)...]) + Array(shortMonthSymbols[0...(currentMonthIndex)])

        return grouped.map { key, value in
            let totalDistractions = value.reduce(0) { $0 + $1.distractions }
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM"
            let monthString = dateFormatter.string(from: Calendar.current.date(from: key)!)
            return (monthString, totalDistractions)
        }
        .sorted { first, second in
            sortedMonths.firstIndex(of: first.month)! < sortedMonths.firstIndex(of: second.month)!
        }
    }

    func updateData(focusSessions: [FocusSession]) {
        self.focusSessions = focusSessions
    }
}
