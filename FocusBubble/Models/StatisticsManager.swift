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

    static var mock: StatisticsManager {
        let mockData = (0..<12).map { offset in
            FocusSession(
                date: Calendar.current.date(byAdding: .day, value: -30 * offset, to: Date()) ?? Date(),
                focusTime: TimeInterval(Int.random(in: 1800...14400)), // Random focus time between 30 min and 4 hours
                distractions: Int.random(in: 0...10) // Random distractions between 0 and 10
            )
        }
        let manager = StatisticsManager()
        manager.updateData(focusSessions: mockData)
        return manager
    }

    private var shortMonthSymbols: [String] { Calendar.current.shortMonthSymbols }
    var currentMonthIndex: Int { Calendar.current.component(.month, from: Date()) - 1 }
    var sortedMonths: [String] {
        Array(shortMonthSymbols[(currentMonthIndex + 1)...]) + Array(shortMonthSymbols[0...currentMonthIndex])
    }

    private func groupedSessions(by component: Calendar.Component) -> [DateComponents: [FocusSession]] {
        Dictionary(grouping: focusSessions) { session in
            Calendar.current.dateComponents([.year, .month], from: session.date)
        }
    }

    private func formattedMonth(from dateComponents: DateComponents) -> String? {
        guard let date = Calendar.current.date(from: dateComponents) else { return nil }
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        return formatter.string(from: date)
    }

    private func sortedMonthlyData<T>(
        groupedData: [DateComponents: [FocusSession]],
        dataExtractor: (FocusSession) -> T,
        aggregator: ([T]) -> T
    ) -> [(month: String, value: T)] {
        groupedData.compactMap { key, sessions in
            guard let monthString = formattedMonth(from: key) else { return nil }
            let values = sessions.map(dataExtractor)
            return (monthString, aggregator(values))
        }
        .sorted { first, second in
            guard
                let firstIndex = sortedMonths.firstIndex(of: first.month),
                let secondIndex = sortedMonths.firstIndex(of: second.month)
            else {
                return false
            }
            return firstIndex < secondIndex
        }
    }

    var monthlyFocusTimeData: [(month: String, totalFocusTime: TimeInterval)] {
        let grouped = groupedSessions(by: .month)
        return sortedMonthlyData(
            groupedData: grouped,
            dataExtractor: { $0.focusTime },
            aggregator: { $0.reduce(0, +) }
        )
        .map { (month, value) in (month: month, totalFocusTime: value) }
    }

    var monthlyDistractionsData: [(month: String, totalDistractions: Int)] {
        let grouped = groupedSessions(by: .month)
        return sortedMonthlyData(
            groupedData: grouped,
            dataExtractor: { $0.distractions },
            aggregator: { $0.reduce(0, +) }
        )
        .map { (month, value) in (month: month, totalDistractions: value) }
    }

    func updateData(focusSessions: [FocusSession]) {
        self.focusSessions = focusSessions
    }
}

