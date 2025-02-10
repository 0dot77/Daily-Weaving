//
//  ContentView.swift
//  CC-0207-007
//
//  Created by taeyang on 2/8/25.
//

import SwiftUI

struct ContentView: View {
    @State private var randomOffsets: [CGPoint] = (0..<100).map { _ in
        CGPoint(x: CGFloat.random(in: -300...300), y: CGFloat.random(in: -500...500))
    }
    @State private var rotationAngle: Double = 0
    @State private var starOpacity: Double = 0
    var body: some View {
        VStack {
            Button {
                withAnimation(.spring()){
                    rotationAngle += 180
                    starOpacity = starOpacity == 1 ? 0 : 1
                }
            } label: {
                RoundedRectangle(cornerRadius: 20)
                    .frame(width:10, height:200)
                    .shadow(radius:10)
                    .foregroundColor(Color.black)
                    .rotationEffect(Angle(degrees: rotationAngle))
            }
        }
        ZStack {
            ForEach (0..<randomOffsets.count, id: \.self) { index in
                Image(systemName: "star.fill") .foregroundColor(.yellow)
                    .opacity(starOpacity)
                    .offset(x: randomOffsets[index].x, y: randomOffsets[index].y)
            }
        }
    }
}

#Preview {
    ContentView()
}
