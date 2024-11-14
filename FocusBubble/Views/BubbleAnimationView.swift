//
//  BubbleAnimationView.swift
//  FocusBubble
//
//  Created by Daniele Fontana on 14/11/24.
//

import SwiftUI

struct BubbleAnimationView: View {
    var imageName: String
    var animationDuration: Double = 1.5
    var maxOffset: CGFloat = 10

    @State private var xOffset: CGFloat = 0
    @State private var yOffset: CGFloat = 0

    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFill()
            .frame(width: 140, height: 140)
            .offset(x: xOffset, y: yOffset)
            .onAppear {
               
                withAnimation(.easeInOut(duration: animationDuration).repeatForever(autoreverses: true)) {
                    xOffset = CGFloat.random(in: -maxOffset...maxOffset)
                    yOffset = CGFloat.random(in: -maxOffset...maxOffset)
                }
            }
    }
}

#Preview {
    BubbleAnimationView(imageName: "Bubble100")
}

