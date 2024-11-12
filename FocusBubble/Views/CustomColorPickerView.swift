//
//  CustomColorPickerView.swift
//  FocusBubble
//
//  Created by Jan Armbrust on 12/11/24.
//

import SwiftUI

struct CustomColorPickerView: View {
    @Binding var selectedColor: Color
    let colors: [Color] = [
        .purple,
        .red,
        .orange,
        
    ]

    var body: some View {
        HStack {
            Text("Select preset color")
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(colors, id: \.self) { color in
                        Button {
                            self.selectedColor = color
                        } label: {
                            Circle()
                                .fill(color)
                                .frame(width: 20, height: 20)
                                .overlay(
                                    Circle()
                                        .stroke(selectedColor.opacity(0.5), lineWidth: selectedColor == color ? 5 : 0)
                                )
                        }
                    }
                }
                .padding([.leading, .vertical])
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    CustomColorPickerView(selectedColor: .constant(.red))
}
