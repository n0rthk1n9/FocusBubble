//
//  MotionManager.swift
//  FocusBubble
//
//  Created by Jan Armbrust on 13/11/24.
//

import CoreMotion
import SwiftUI

@Observable
class MotionManager {
    private var motionManager = CMMotionManager()
    var movementDetected = false

    func startMotionDetection(threshold: Double = 1.3, onMovementDetected: @escaping () -> Void) {
        motionManager.accelerometerUpdateInterval = 1.0 / 300.0
        motionManager.startAccelerometerUpdates(to: .main) { data, error in
            guard let data = data, error == nil else { return }
            
            if abs(data.acceleration.x) > threshold ||
                abs(data.acceleration.y) > threshold ||
                abs(data.acceleration.z) > threshold {
                
                if !self.movementDetected {
                    self.movementDetected = true
                    onMovementDetected()
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.movementDetected = false
                    }
                }
            }
        }
    }

    func stopMotionDetection() {
        motionManager.stopAccelerometerUpdates()
    }
}
