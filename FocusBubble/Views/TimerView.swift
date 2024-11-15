//
//  TimerView.swift
//  FocusBubble
//
//  Created by Jan Armbrust on 12/11/24.
//

import SwiftUI

struct TimerView: View {
    @Environment(\.timerManager) var timerManager
    let controls: Bool

    var body: some View {
        VStack {
            Text(displayedTime(timerManager.remainingTime))
                .monospacedDigit()
                .font(.system(size: 100, design: .rounded))
                .foregroundStyle(timerManager.timerColor)
                .bold()
                .contentTransition(.numericText())
                .animation(.linear, value: timerManager.remainingTime)
            HStack {
                Button {
                    let impact = UIImpactFeedbackGenerator(style: .medium)
                    impact.impactOccurred()
                    timerManager.startTimer()
                } label: {
                    Image(systemName: "play.fill")
                }
                .modifier(ControlButtonStyle(color: timerManager.timerColor, disabled: timerManager.playButtonDisabled))
                Button {
                    timerManager.stopTimer()
                    let impact = UIImpactFeedbackGenerator(style: .medium)
                    impact.impactOccurred()
                } label: {
                    Image(systemName: "pause.fill")
                }
                .modifier(ControlButtonStyle(color: timerManager.timerColor, disabled: timerManager.pauseButtonDisabled))
                Button {
                    timerManager.resetTimer()
                    let impact = UIImpactFeedbackGenerator(style: .rigid)
                    impact.impactOccurred()
                } label: {
                    Image(systemName: "gobackward")
                }
                .modifier(ControlButtonStyle(color: timerManager.timerColor, disabled: timerManager.resetButtonDisabled))
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
        .environment(TimerManager())
}
