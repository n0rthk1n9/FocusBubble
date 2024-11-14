//
//  HapticsManager.swift
//  FocusBubble
//
//  Created by Jan Armbrust on 13/11/24.
//

import CoreHaptics

@Observable
class HapticsManager {
    private var engine: CHHapticEngine?

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

        let hapticEvent = CHHapticEvent(
            eventType: .hapticContinuous,
            parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.5),
            ], relativeTime: 0, duration: 0.3
        )

        do {
            let pattern = try CHHapticPattern(events: [hapticEvent], parameters: [])
            let player = try engine.makePlayer(with: pattern)
            try player.start(atTime: 0)
        } catch {
            print("Haptic feedback error: \(error.localizedDescription)")
        }
    }
}
