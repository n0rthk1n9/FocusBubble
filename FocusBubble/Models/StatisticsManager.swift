//
//  StatisticsManager.swift
//  FocusBubble
//
//  Created by Daniele Fontana on 13/11/24.
//

import SwiftUI

@Observable
class StatisticsManager {
    var hoursPerMonth: [Int]
    var bubblesPoppedPerMonth: [Int]
    var months: [String]
    var dailyHours: [String: Double]
    
    init(
        hoursPerMonth: [Int] = [10, 15, 20, 18, 25, 30, 40, 15, 12, 20, 28, 30],
        bubblesPoppedPerMonth: [Int] = [5, 6, 7, 4, 5, 9, 6, 5, 4, 7, 8, 6],
        months: [String] = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
        dailyHours: [String: Double] = ["Mon": 1, "Tue": 2, "Wed": 1, "Thu": 3, "Fri": 2, "Sat": 1, "Sun": 2.5]
        
    ) {
        self.hoursPerMonth = hoursPerMonth
        self.bubblesPoppedPerMonth = bubblesPoppedPerMonth
        self.months = months
        self.dailyHours = dailyHours
    }
    
    func updateData(hours: [Int], bubbles: [Int], dailyHours: [String: Double]) {
        self.hoursPerMonth = hours
        self.bubblesPoppedPerMonth = bubbles
        self.dailyHours = dailyHours  
    }
}

