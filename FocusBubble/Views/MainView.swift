//
//  ContentView.swift
//  FocusBubble
//
//  Created by Jan Armbrust on 12/11/24.
//

import SwiftUI

struct MainView: View {
    @Environment(\.timerManager) var timerManager
    
    @State var showStatisticsView: Bool = false
    @State var showSettingsView: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                BubbleView()
                TimerView(controls: true)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showStatisticsView.toggle()
                        timerManager.resetTimer()
                    } label: {
                        Image(systemName: "chart.bar")
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        showSettingsView.toggle()
                        timerManager.resetTimer()
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
            .navigationTitle("Focus Bubble")
        }
    }
}

#Preview {
    MainView()
        .environment(TimerManager())
}
