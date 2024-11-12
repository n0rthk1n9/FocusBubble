//
//  TimerView.swift
//  FocusBubble
//
//  Created by Jan Armbrust on 12/11/24.
//

import SwiftUI

struct TimerView: View {
    @Environment(TimerObject.self) var timerObject
    let controls: Bool
    
    var body: some View {
        VStack {
            Text(displayedTime(timerObject.remainingTime))
                .monospacedDigit()
                .font(.system(size: 100))
                .foregroundStyle(timerObject.timerColor)
                .bold()
                .contentTransition(.numericText())
                .animation(.linear, value: timerObject.remainingTime)
            HStack {
                Button {
                    timerObject.startTimer()
                } label: {
                    Image(systemName: "play.fill")
                }
                .modifier(ControlButtonStyle(color: timerObject.timerColor, disabled: timerObject.playButtonDisabled))
                Button {
                    timerObject.stopTimer()
                } label: {
                    Image(systemName: "pause.fill")
                }
                .modifier(ControlButtonStyle(color: timerObject.timerColor, disabled: timerObject.pauseButtonDisabled))
                Button {
                    timerObject.resetTimer()
                } label: {
                    Image(systemName: "gobackward")
                }
                .modifier(ControlButtonStyle(color: timerObject.timerColor, disabled: timerObject.resetButtonDisabled))
            }
        }
    }
    
    func displayedTime(_ totalSeconds: Int) -> String {
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: "%01d:%02d", minutes, seconds)
    }
}

struct ControlButtonStyle: ViewModifier {
    let color: Color
    let disabled: Bool
    
    func body(content: Content) -> some View {
        content
            .font(.title)
            .bold()
            .frame(width: 50, height: 50)
            .background(color).opacity(disabled ? 0.5 : 1)
            .foregroundStyle(.white)
            .clipShape(Circle())
            .disabled(disabled)
    }
}

#Preview {
    TimerView(controls: true)
        .environment(TimerObject())
}
