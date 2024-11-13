//
//  BubbleView.swift
//  FocusBubble
//
//  Created by Jan Armbrust on 13/11/24.
//

import SwiftUI
import CoreMotion
import CoreHaptics

struct BubbleView: View {
    @Environment(TimerObject.self) var timerObject

    @State private var xAmplitude: CGFloat = 0
    @State private var yAmplitude: CGFloat = 0
    @State private var motionManager = CMMotionManager()
    @State private var engine: CHHapticEngine?
    @State private var movementDetected = false

    var imageName: String {
        let stage = max((10 - Int(timerObject.progress * 10)) * 10, 10)
        return "Bubble\(stage)"
    }
    
    var maxStep: CGFloat {
        switch imageName {
        case "Bubble10":
            return 20
        case "Bubble20":
            return 18
        case "Bubble30":
            return 16
        case "Bubble40":
            return 14
        case "Bubble50":
            return 12
        case "Bubble60":
            return 10
        case "Bubble70":
            return 8
        case "Bubble80":
            return 6
        case "Bubble90":
            return 4
        case "Bubble100":
            return 2
        default:
            return 15
        }
    }

    var body: some View {
        Image(imageName)
            .resizable()
            .frame(width: 400, height: 400)
            .offset(x: xAmplitude, y: yAmplitude)
            .animation(.easeInOut(duration: 1.5), value: imageName)
            .onAppear {
                prepareHaptics()
                
                Timer.scheduledTimer(withTimeInterval: 1.2, repeats: true) { _ in
                    withAnimation(.easeInOut(duration: 1.2)) {
                        xAmplitude += CGFloat.random(in: -maxStep...maxStep)
                        yAmplitude += CGFloat.random(in: -maxStep...maxStep)
                        xAmplitude = min(max(xAmplitude, -30), 30)
                        yAmplitude = min(max(yAmplitude, -30), 30)
                    }
                }
            }
            .onChange(of: timerObject.isTimerRunning) { isRunning in
                if isRunning {
                    startMotionDetection()  // Start motion detection when timer is running
                    prepareHaptics()
                } else {
                    stopMotionDetection()   // Stop motion detection when timer is paused or stopped
                }
            }
    }
    
    func startMotionDetection() {
        motionManager.accelerometerUpdateInterval = 1.0 / 300.0
        motionManager.startAccelerometerUpdates(to: .main) { data, error in
            guard let data = data, error == nil else { return }
            
            let threshold: Double = 1.3
            if abs(data.acceleration.x) > threshold ||
                abs(data.acceleration.y) > threshold ||
                abs(data.acceleration.z) > threshold {
                
                if !movementDetected {
                    movementDetected = true
                    timerObject.stopTimer()  // Pause the timer without resetting timeElapsed
                    triggerHapticFeedback()
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        movementDetected = false
                    }
                }
            }
        }
    }
    
    func stopMotionDetection() {
        motionManager.stopAccelerometerUpdates()
    }

    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("Haptic engine creation error: \(error.localizedDescription)")
        }
    }
    
    func triggerHapticFeedback() {
        guard let engine = engine else { return }

        let hapticEvent = CHHapticEvent(eventType: .hapticContinuous, parameters: [
            CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0),  // Strongest intensity
            CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.5)   // Balanced sharpness for a richer feel
        ], relativeTime: 0, duration: 0.3)  // Slight duration for sustained feedback

        do {
            let pattern = try CHHapticPattern(events: [hapticEvent], parameters: [])
            let player = try engine.makePlayer(with: pattern)
            try player.start(atTime: 0)
        } catch {
            print("Haptic feedback error: \(error.localizedDescription)")
        }
    }
}

#Preview {
    BubbleView()
        .environment(TimerObject())
}
