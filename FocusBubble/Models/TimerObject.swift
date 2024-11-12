//
//  TimerObject.swift
//  FocusBubble
//
//  Created by Jan Armbrust on 12/11/24.
//

import SwiftUI

@Observable
class TimerObject {
    let timerColor: Color
    let length: Int
    
    init(timerColor: Color, length: Int) {
        self.timerColor = timerColor
        self.length = length
    }
    
    var timer: Timer? = nil
    var timeElapsed: Int = 0
    var isTimerRunning: Bool = false
    
    var remainingTime: Int {
        length - timeElapsed
    }
    
    var progress: CGFloat {
        CGFloat(length - timeElapsed) / CGFloat(length)
    }
    
    var playButtonDisabled: Bool {
        guard self.remainingTime > 0, !self.isTimerRunning else { return true }
        return false
    }
    
    var pauseButtonDisabled: Bool {
        guard self.remainingTime > 0, self.isTimerRunning else { return true }
        return false
    }
    
    var resetButtonDisabled: Bool {
        guard self.remainingTime != self.length, !self.isTimerRunning else { return true }
        return false
    }
    
    func startTimer() {
        isTimerRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if self.remainingTime > 0 {
                self.timeElapsed += 1
            } else {
                self.stopTimer()
            }
        }
    }
    
    func stopTimer() {
        isTimerRunning = false
        timer?.invalidate()
    }
    
    func resetTimer() {
        timeElapsed = 0
        isTimerRunning = false
    }
}
