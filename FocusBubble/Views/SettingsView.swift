//
//  SettingsView.swift
//  FocusBubble
//
//  Created by Jan Armbrust on 12/11/24.
//

import SwiftUI

struct SettingsView: View {
    @Environment(TimerObject.self) var timerObject
    
    @State private var selectedTime: Int = 1200
    
    let timeOptions = ["15:00": 900, "20:00 (Default)": 1200, "25:00": 1500]

    var body: some View {
        Form {
            Section("Test") {
                @Bindable var timerObject = timerObject
                Picker("Select a time", selection: $timerObject.length) {
                    ForEach(timeOptions.keys.sorted(), id: \.self) { key in
                        Text(key)
                            .tag(timeOptions[key] ?? 1200)
                    }
                }
            }
        }
    }
}

#Preview {
    SettingsView()
        .environment(TimerObject())
}
