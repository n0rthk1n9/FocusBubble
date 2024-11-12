//
//  ContentView.swift
//  FocusBubble
//
//  Created by Jan Armbrust on 12/11/24.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationStack {
            Text("MainView")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            // open Statistics View
                        } label: {
                            Image(systemName: "chart.bar")
                        }
                    }
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            // open settings view
                        } label: {
                            Image(systemName: "gear")
                        }
                    }
                }
        }

    }
}

#Preview {
    MainView()
}
