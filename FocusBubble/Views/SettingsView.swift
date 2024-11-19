//
//  SettingsView.swift
//  FocusBubble
//
//  Created by Jan Armbrust on 12/11/24.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.timerManager) var timerManager
    @Environment(\.dismiss) var dismiss

    let presetTimeOptions = ["0:30 (Default)": 30, "15:00": 900, "20:00": 1200, "25:00": 1500]
    let wheelOptions = [30] + [300, 420] + Array(stride(from: 600, through: 3600, by: 300))

    var body: some View {
        @Bindable var timerObject = timerManager
        NavigationStack {
            Form {
                Section("Appearance") {
                    Section {
                        ColorPicker("Select a custom color", selection: $timerObject.timerColor)
                        CustomColorPickerView(selectedColor: $timerObject.timerColor)
                    }
                }

                Section("Timer") {
                    Picker("Select a preset", selection: $timerObject.length) {
                        ForEach(presetTimeOptions.keys.sorted(), id: \.self) { key in
                            Text(key)
                                .tag(presetTimeOptions[key] ?? 1200)
                        }
                        Text("Custom: \(displayedTime(timerManager.length))")
                            .tag(timerManager.length)
                    }
                    .tint(.secondary)
                    VStack {
                        HStack {
                            Text("Select a specific time")
                            Spacer()
                            Text(displayedTime(timerObject.length))
                                .monospacedDigit()
                                .font(.system(.title, design: .rounded))
                                .foregroundStyle(timerManager.timerColor)
                                .bold()
                                .contentTransition(.numericText())
                                .animation(.linear, value: timerObject.length)
                        }
                        Picker(
                            "Select time",
                            selection: $timerObject.length
                        ) {
                            ForEach(wheelOptions, id: \.self) { seconds in
                                if seconds < 60 {
                                    Text("\(seconds) sec").tag(seconds)
                                } else {
                                    Text("\(seconds / 60) min").tag(seconds)
                                }
                            }
                        }
                        .pickerStyle(.wheel)
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }

    func displayedTime(_ totalSeconds: Int) -> String {
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: "%01d:%02d", minutes, seconds)
    }
}

#Preview {
    SettingsView()
        .environment(TimerManager())
}
