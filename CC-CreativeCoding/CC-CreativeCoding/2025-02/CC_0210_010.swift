//
//  CC_0210_010.swift
//  CC-CreativeCoding
//
//  Created by taeyang on 2/10/25.
//

import SwiftUI

struct CC_0210_010: View {
    let colors: [Color] = [.red, .orange, .yellow, .green, .blue, .teal, .indigo, .mint]
    
    @State var scale :CGFloat = 1.0
    
    var body: some View {
        ZStack {
            SwiftBird()
                .fill(Color.white)
                .frame(width:50, height:50)
                .scaleEffect(scale)
                .onAppear {
                    withAnimation(.easeInOut(duration: 2).repeatForever()) {
                        scale = 1.5
                    }
                }
                
            
            ForEach (0..<10) { index in
                SwiftBird()
                    .stroke(style: StrokeStyle(lineWidth: 1, lineCap: .round, lineJoin: .round))
                    .fill(self.colors[index % self.colors.count])
                    .rotationEffect(Angle(degrees: 360 * Double(index) / 10))
                    .shadow(radius: 2, x:0, y:10)
            }
        }
        .frame(width:.infinity, height:.infinity)
        .background(Color.black)
    }
}


struct SwiftBird: Shape {
    func path(in rect: CGRect) -> Path {
        let size = min(rect.width, rect.height)
        var path = Path()
        
        path.move(to: CGPoint(x: 0.565, y: 0.145))
        for (ptX, ptY, controlPtX, controlPtY): (CGFloat, CGFloat, CGFloat, CGFloat) in [
            (0.79, 0.62, 0.85, 0.34),       // path A -> B
            (0.845, 0.825, 0.88, 0.75),     // path B -> C
            (0.67, 0.775, 0.78, 0.715),     // path C -> D
            (0.5, 0.82, 0.6, 0.82),         // path D -> E
            (0.1, 0.58, 0.25, 0.8),         // path E -> F
            (0.525, 0.63, 0.325, 0.735),    // path F -> G
            (0.175, 0.25, 0.305, 0.445),    // path G -> H
            (0.475, 0.475, 0.36, 0.405),    // path H -> I
            (0.26, 0.205, 0.4, 0.405),      // path I -> J
            (0.63, 0.505, 0.465, 0.405),    // path J -> K
            (0.565, 0.145, 0.7, 0.355),     // path K -> A
        ] {
            path.addQuadCurve(
                to: CGPoint(x: ptX, y: ptY),
                control: CGPoint(x: controlPtX, y: controlPtY)
            )
        }
        
        path.closeSubpath()
        path = path.applying(.init(scaleX: size, y: size))
        return path
    }
}

#Preview {
    CC_0210_010()
}
