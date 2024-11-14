//
//  SettingsView.swift
//  FocusBubble
//
//  Created by Jan Armbrust on 12/11/24.
//

import SwiftUI

struct SettingsView: View {
    @Environment(TimerObject.self) var timerObject
    
    let colorOptions: [Color] = [.red, .blue, .green]
    
    @State private var changeColor = 0
    @State private var selectedMinutes: Int = 50
    @State private var selectedBreakMinutes: Int = 10
    @State private var selectedMode: Int = 0
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Appearence")
                    .font(.title)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20)
                    .padding(.vertical, 5)
                
                Text("Choose your theme color as you wish")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20)
                    .padding(.vertical, 5)
                
                VStack {
                    Picker("Change color", selection: $changeColor) {
                        Text("Bubble").tag(0)
                        Text("Timer").tag(1)
                        Text("Background").tag(2)
                    }
                    .pickerStyle(.segmented)
                    
                    Section {
                        @Bindable var timerObject = timerObject
                        ColorPicker("Select a custom color", selection: $timerObject.timerColor)
                        CustomColorPickerView(selectedColor: $timerObject.timerColor)
                    }
                    
                    VStack {
                        Picker("Select mode", selection: $selectedMode) {
                            Text("Timer").tag(0)
                            Text("Break").tag(1)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    
                    .pickerStyle(SegmentedPickerStyle())
                    
                    Text(formatTime(minutes: selectedMode == 0 ? selectedMinutes : selectedBreakMinutes))
                        .font(.system(size: 60))
                        .bold()
                        .padding()
                        .monospacedDigit()
                        .contentTransition(.numericText())
                        .animation(.linear, value: selectedMinutes)
                        .animation(.linear, value: selectedBreakMinutes)
                    
                    Picker("Select time in minutes", selection: selectedMode == 0 ? $selectedMinutes : $selectedBreakMinutes) {
                        ForEach(1..<121) { minute in
                            Text("\(minute) min").tag(minute)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .onChange(of: selectedMinutes) { newValue in
                        if selectedMode == 0 {
                            timerObject.length = newValue * 60
                        }
                    }
                    .onChange(of: selectedBreakMinutes) { newValue in
                        if selectedMode == 1 {
                            timerObject.breakLength = newValue * 60
                        }
                    }
                }
                .padding(.horizontal)
                
                HStack {
                    Button {
                        //
                    } label: {
                        Text("Cancle")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.bordered)
                    .tint(.primary)
                    
                    Button {
                        //
                    } label: {
                        Text("Save")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.bordered)
                    .tint(.primary)

                        
                }
                .padding([.horizontal, .top])
            }
            .navigationTitle("Settings")
        }
    }
    
    func formatTime(minutes: Int) -> String {
        return String(format: "%02d:00", minutes)
    }
}

#Preview {
    SettingsView()
        .environment(TimerObject())
}
