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
    
    init() {
        self.hoursPerMonth = [10, 15, 20, 18, 25, 30, 40, 15, 12, 20, 28, 30] // example data for hours
        self.bubblesPoppedPerMonth = [5, 6, 7, 4, 5, 9, 6, 5, 4, 7, 8, 6] // example data for bubbles popped
        self.months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    }
    
    func updateData(hours: [Int], bubbles: [Int]) {
        self.hoursPerMonth = hours
        self.bubblesPoppedPerMonth = bubbles
    }
}

