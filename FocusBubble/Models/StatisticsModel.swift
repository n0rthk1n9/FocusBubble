//
//  StatisticsModel.swift
//  FocusBubble
//
//  Created by Daniele Fontana on 13/11/24.
//

import SwiftUI

class StatisticsModel: ObservableObject {
    @Published var hoursPerMonth: [Int]
    @Published var bubblesPoppedPerMonth: [Int]
    @Published var months: [String]
    @Published var dailyHours: [String: Double]
    
    init() {          //default values
        self.hoursPerMonth = [10, 15, 20, 18, 25, 30, 40, 15, 12, 20, 28, 30]
        self.bubblesPoppedPerMonth = [5, 6, 7, 4, 5, 9, 6, 5, 4, 7, 8, 6]
        self.months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        self.dailyHours = ["Mon": 1, "Tue": 2, "Wed": 1, "Thu": 3, "Fri": 2, "Sat": 1, "Sun": 2.5]
    }
    
    func updateData(hours: [Int], bubbles: [Int], dailyHours: [String: Double]) {
        self.hoursPerMonth = hours
        self.bubblesPoppedPerMonth = bubbles
        self.dailyHours = dailyHours  
    }
}

