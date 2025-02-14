//
//  CC_0213_013.swift
//  CC-CreativeCoding
//
//  Created by taeyang on 2/15/25.
//

import SwiftUI

struct CC_0213_013: View {
    private var columns = 10
    private var rows = 20
    
    @State private var backgroundColors: [Color] = [.black, .cyan]
    var body: some View {
        GeometryReader { geometry in
            let gridItemWidth = geometry.size.width / CGFloat(self.columns)
            let gridItemHeight = geometry.size.height / CGFloat(self.rows)
            
            
            ForEach(0..<rows, id: \.self) { row in
                ForEach(0..<columns, id:\.self) { column in
                    Rectangle()
                        .fill(Color(
                            hue: Double.random(in:0...1),
                            saturation: Double.random(in:0.5...1),
                            brightness: Double.random(in:0.7...1),
                            opacity:1.0
                        ))
                        .frame(width: gridItemWidth-5, height: gridItemHeight-5)
                        .position(x: gridItemWidth * CGFloat(column) + gridItemWidth / 2,
                                  y: gridItemHeight * CGFloat(row) + gridItemHeight / 2
                        )
                }
            }
        }
        .frame(maxWidth:.infinity, maxHeight:.infinity)
        .onAppear {
            generateRandomBackgroundColor()
            
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                generateRandomBackgroundColor()
            }
        }
        .background(
            LinearGradient(gradient: Gradient(colors: backgroundColors),
                           startPoint: .topLeading, endPoint: .bottomTrailing)
                .animation(.easeInOut(duration: 1), value: backgroundColors)
        )
        .edgesIgnoringSafeArea(.all)
    }
    
    private func generateRandomBackgroundColor() {
        backgroundColors = [
            Color(hue: Double.random(in: 0...1),
                  saturation: Double.random(in: 0.5...1),
                  brightness: Double.random(in: 0.7...1),
                  opacity: 1.0),
            Color(hue: Double.random(in: 0...1),
                  saturation: Double.random(in: 0.5...1),
                  brightness: Double.random(in: 0.7...1),
                  opacity: 1.0)
        ]
    }
}

#Preview {
    CC_0213_013()
}
