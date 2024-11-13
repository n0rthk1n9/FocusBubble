//
//  TimerObject.swift
//  FocusBubble
//
//  Created by Jan Armbrust on 12/11/24.
//

import SwiftUI

@Observable
class TimerObject {
    var timerColor: Color
    var length: Int
    var breakLength: Int

    
    init(timerColor: Color = .red, length: Int = 1200, breakLength: Int = 600) {
        self.timerColor = timerColor
        self.length = length
        self.breakLength = breakLength
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
