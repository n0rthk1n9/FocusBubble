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
    
    init(timerColor: Color = .red, length: Int = 30) {
        self.timerColor = timerColor
        self.length = length
        self.baseRemainingTime = length  // Initially, baseRemainingTime is the full length
    }
    
    var timer: Timer? = nil
    var timeElapsed: Int = 0
    var isTimerRunning: Bool = false
    private var baseRemainingTime: Int  // Base remaining time when the timer was last stopped

    var remainingTime: Int {
        length - timeElapsed
    }
    
    var progress: CGFloat {
        CGFloat(remainingTime) / CGFloat(baseRemainingTime)
    }
    
    var playButtonDisabled: Bool {
        // Disable play button if the timer has run out or is already running
        return remainingTime == 0 || isTimerRunning
    }
    
    var pauseButtonDisabled: Bool {
        // Disable pause button if the timer is not running or has run out
        return !isTimerRunning || remainingTime == 0
    }
    
    var resetButtonDisabled: Bool {
        // Enable reset button only if the timer has run out or is paused (with elapsed time)
        return remainingTime == length || isTimerRunning
    }
    
    func startTimer() {
        isTimerRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if self.remainingTime > 0 {
                self.timeElapsed += 1
            } else {
                self.stopTimer()  // Stop the timer when it reaches 0
            }
        }
    }
    
    func stopTimer() {
        isTimerRunning = false
        timer?.invalidate()
        baseRemainingTime = remainingTime  // Set baseRemainingTime to the current remaining time
    }
    
    func resetTimer() {
        timeElapsed = 0
        baseRemainingTime = length  // Reset baseRemainingTime to the full length
        isTimerRunning = false
        timer?.invalidate()
    }
}
