//
//  ContentView.swift
//  CC-0202-002
//
//  Created by taeyang on 2/2/25.
//

import SwiftUI

struct MyCircle: View {
    let circleWidth: CGFloat
    let circleHeight: CGFloat
    let circleColor: Color
    
    var body: some View {
        Circle()
            .frame(width:circleWidth, height:circleHeight)
            .foregroundStyle(circleColor)
    }
    
    
}

struct ContentView: View {
    
    private let circleNum: Int = 10
    private let radius: CGFloat = 150
    private let colorSet: [Color] = [.red, .blue, .green, .yellow, .orange, .purple]
    
    // type을 명확하게 명시해주기
    @State private var isAnimation: Bool = false
    @State private var rotation: Angle = .zero
    
    var body: some View {
        ZStack {
            Button() {
                withAnimation(.easeInOut(duration: 1)) {
                    // self 키워드를 사용해서 struct 내부 변수를 사용하는 것을 명시화
                    self.isAnimation.toggle()
                }
                
                withAnimation(.linear(duration: 1))
                {
                    self.rotation += Angle(degrees: 45)
                }
            } label: {
                Circle()
                    .frame(width:isAnimation ? 100 : 200, height:200)
                    .foregroundStyle(.black)
            }
            ZStack {
                ForEach(0..<circleNum, id: \.self) { i in
                    let angle = Double(i) * (2 * .pi / Double(circleNum))
                    MyCircle(circleWidth: 50, circleHeight: 50, circleColor: colorSet[i % colorSet.count])
                        .opacity(isAnimation ? 1 : 0)
                        .offset(
                            x : CGFloat(cos(angle)) * radius,
                            y : CGFloat(sin(angle)) * radius
                        )
                }
            }
            .rotationEffect(rotation)
        }
    }
}

#Preview {
    ContentView()
}
