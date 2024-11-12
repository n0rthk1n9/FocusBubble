//
//  ContentView.swift
//  FocusBubble
//
//  Created by Jan Armbrust on 12/11/24.
//

import SwiftUI

struct MainView: View {
    @State var showStatisticsView: Bool = false
    @State var showSettingsView: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                TimerView(timerObject: TimerObject(timerColor: .red, length: 122), controls: true)
                Spacer()
                Button {
                    // start timer
                } label: {
                    Label("Start", systemImage: "play")
                        .font(.largeTitle)
                }
                .buttonStyle(.borderedProminent)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showStatisticsView.toggle()
                    } label: {
                        Image(systemName: "chart.bar")
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        showSettingsView.toggle()
                    } label: {
                        Image(systemName: "gear")
                    }
                }
            }
            .sheet(isPresented: $showStatisticsView) {
                StatisticsView()
            }
            .sheet(isPresented: $showSettingsView) {
                SettingsView()
            }
        }
    }
}

#Preview {
    MainView()
}
