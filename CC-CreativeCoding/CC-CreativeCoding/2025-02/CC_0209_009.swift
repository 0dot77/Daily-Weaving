//
//  CC-0209-009.swift
//  CC-CreativeCoding
//
//  Created by taeyang on 2/9/25.
//

import SwiftUI

struct CC_0209_009: View {
    @State private var phase: CGFloat = 0
    
    var body: some View {
        GeometryReader { geometry in
            PhaseAnimator([false, true]) { animate in
                HStack(spacing:30){
                    ForEach (0..<10) { i in
                        SpringShape(amplitude: 10, frequency: 1, xPos: CGFloat(5 * i))
                                .trim(from:0, to:animate ? 0: 1)
                                .stroke(Color.green.gradient, lineWidth: CGFloat(i))
                                .frame(width:10, height:geometry.size.height, alignment: .topLeading)
                                .animation(.spring(duration: 2.0), value: animate)
                        }
                    }
                }
            
            }
        .ignoresSafeArea(.all)
        .background(.black)
    }
}

struct SpringShape:Shape {
    var amplitude: CGFloat
    var frequency: CGFloat
    
    var xPos:CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.width
        let height = rect.height
        let waveLength = height / frequency
        
        path.move(to: CGPoint(x:xPos, y:0))
        
        for y in stride(from:0, through: height, by:1) {
            let relativeY = y / waveLength
            let sine = sin(relativeY * .pi * 2)
            let x = xPos + sine * amplitude
            path.addLine(to: CGPoint(x:x, y:y))
        }
        
        return path
    }
}

#Preview {
    CC_0209_009()
}
