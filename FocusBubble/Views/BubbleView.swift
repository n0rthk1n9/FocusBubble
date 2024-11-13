//
//  BubbleView.swift
//  FocusBubble
//
//  Created by Jan Armbrust on 13/11/24.
//

import CoreMotion
import SwiftUI

struct BubbleView: View {
    @Environment(TimerObject.self) var timerObject

    @State private var audioManager = AudioManager()
    @State private var hapticsManager = HapticsManager()
    @State private var motionManager = MotionManager()

    @State private var xAmplitude: CGFloat = 0
    @State private var yAmplitude: CGFloat = 0

    var imageName: String {
        let progressValue = timerObject.progress.isNaN || timerObject.progress.isInfinite ? 0.0 : timerObject.progress
        let stage = max((10 - Int(progressValue * 10)) * 10, 10)
        return "Bubble\(stage)"
    }

    var maxStep: CGFloat {
        switch imageName {
        case "Bubble10": return 20
        case "Bubble20": return 18
        case "Bubble30": return 16
        case "Bubble40": return 14
        case "Bubble50", "Bubble60", "Bubble70", "Bubble80", "Bubble90", "Bubble100": return 12
        default: return 15
        }
    }

    var body: some View {
        Image(imageName)
            .resizable()
            .frame(width: 200, height: 200)
            .offset(x: xAmplitude, y: yAmplitude)
            .animation(.easeInOut(duration: 1.5), value: imageName)
            .onAppear {
                hapticsManager.prepareHaptics()
                Timer.scheduledTimer(withTimeInterval: 1.2, repeats: true) { _ in
                    withAnimation(.easeInOut(duration: 1.2)) {
                        xAmplitude += CGFloat.random(in: -maxStep...maxStep)
                        yAmplitude += CGFloat.random(in: -maxStep...maxStep)
                        xAmplitude = min(max(xAmplitude, -30), 30)
                        yAmplitude = min(max(yAmplitude, -30), 30)
                    }
                }
            }
            .onChange(of: timerObject.isTimerRunning) { oldValue, newValue in
                if newValue {
                    startMotionDetection()
                    hapticsManager.prepareHaptics()
                } else if oldValue {
                    motionManager.stopMotionDetection()
                }
            }
    }

    func startMotionDetection() {
        motionManager.startMotionDetection {
            timerObject.stopTimer()
            hapticsManager.triggerHapticFeedback()
            audioManager.playSound()
        }
    }
}

#Preview {
    BubbleView()
        .environment(TimerObject())
}
