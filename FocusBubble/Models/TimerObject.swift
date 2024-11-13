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
        self.baseRemainingTime = length
    }
    
    var timer: Timer? = nil
    var timeElapsed: Int = 0
    var isTimerRunning: Bool = false
    private var baseRemainingTime: Int

    var remainingTime: Int {
        length - timeElapsed
    }
    
    var progress: CGFloat {
        CGFloat(remainingTime) / CGFloat(baseRemainingTime)
    }
    
    var playButtonDisabled: Bool {
        return remainingTime == 0 || isTimerRunning
    }
    
    var pauseButtonDisabled: Bool {
        return !isTimerRunning || remainingTime == 0
    }
    
    var resetButtonDisabled: Bool {
        return remainingTime == length || isTimerRunning
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
        baseRemainingTime = remainingTime
    }
    
    func resetTimer() {
        timeElapsed = 0
        baseRemainingTime = length
        isTimerRunning = false
        timer?.invalidate()
    }
}
