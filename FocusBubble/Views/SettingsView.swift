//
//  SettingsView.swift
//  FocusBubble
//
//  Created by Jan Armbrust on 12/11/24.
//

import SwiftUI

struct SettingsView: View {
    @Environment(TimerObject.self) var timerObject

    let timeOptions = ["0:30 (Default)": 30, "15:00": 900, "20:00": 1200, "25:00": 1500]
    let colorOptions: [Color] = [.red, .blue, .green]

    var body: some View {
        NavigationStack {
            Form {
                Section("Time") {
                    @Bindable var timerObject = timerObject
                    Picker("Select a time", selection: $timerObject.length) {
                        ForEach(timeOptions.keys.sorted(), id: \.self) { key in
                            Text(key)
                                .tag(timeOptions[key] ?? 1200)
                        }
                    }
                }
                Section("Color") {
                    @Bindable var timerObject = timerObject
                    ColorPicker("Select a custom color", selection: $timerObject.timerColor)
                    CustomColorPickerView(selectedColor: $timerObject.timerColor)
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
        .environment(TimerObject())
}
