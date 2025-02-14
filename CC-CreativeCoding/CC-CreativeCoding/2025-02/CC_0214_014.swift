//
//  CC_0214_014.swift
//  CC-CreativeCoding
//
//  Created by taeyang on 2/15/25.
//

import SwiftUI

struct CC_0214_014: View {
    
    @State private var customHeight: [Double] = (1..<20).map { _ in Double.random(in:0...500)}
    @State private var animatedLineWidth: CGFloat = 0.5
    
    var body: some View {
        ZStack {
            ForEach(1..<20) { i in
                CustomRectangle(rectWidth: 800, rectHeight: CGFloat(customHeight[i-1]), customLineWidth: animatedLineWidth)
            }
            ForEach(1..<20) { i in
                CustomRectangle(rectWidth: CGFloat(customHeight[i-1]), rectHeight: 900, customLineWidth: animatedLineWidth)
            }
        }
        .edgesIgnoringSafeArea(.all)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
        .onAppear {
            withAnimation(.spring(duration: 5).repeatForever(autoreverses: true)) {
                animatedLineWidth = 1
            }
        }
    }
}

struct CustomRectangle : View {
    let rectWidth: CGFloat
    let rectHeight : CGFloat
    let customLineWidth: CGFloat

    var body: some View {
        Rectangle()
            .stroke(.white, lineWidth: customLineWidth)
            .frame(width:rectWidth, height:rectHeight)
        }
}

#Preview {
    CC_0214_014()
}
