//
//  BubbleView.swift
//  FocusBubble
//
//  Created by Jan Armbrust on 13/11/24.
//

import CoreMotion
import SwiftUI

struct BubbleView: View {
    @Environment(\.timerManager) var timerManager

    @State private var audioManager = AudioManager()
    @State private var hapticsManager = HapticsManager()
    @State private var motionManager = MotionManager()

    @State private var xAmplitude: CGFloat = 0
    @State private var yAmplitude: CGFloat = 0
    @State private var isPopping = false
    @State private var poppingFrame = 100 // Start with BubblePopping100

    var imageName: String {
        if isPopping {
            return "BubblePopping\(poppingFrame)"
        } else {
            let progressValue = timerManager.progress.isNaN || timerManager.progress.isInfinite ? 0.0 : timerManager.progress
            let stage = max((10 - Int(progressValue * 10)) * 10, 10)
            return "Bubble\(stage)"
        }
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
            .frame(width: 250, height: 250)
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
            .onChange(of: timerManager.isTimerRunning) { oldValue, newValue in
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
            startPoppingAnimation()
            timerManager.stopTimer()
            hapticsManager.triggerHapticFeedback()
            audioManager.playSound()
            
        }
    }

    private func startPoppingAnimation() {
        isPopping = true
        poppingFrame = max((10 - Int(timerManager.progress * 10)) * 10, 10) // Start from current bubble stage

        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in // Faster updates
            if poppingFrame > 10 {
                withAnimation(.linear(duration: 0.1)) { // Smooth linear transition
                    poppingFrame -= 10
                }
            } else {
                timer.invalidate()
                isPopping = false
                poppingFrame = 100 // Reset for next animation
            }
        }
    }
}

#Preview {
    BubbleView()
        .environment(TimerManager())
}
