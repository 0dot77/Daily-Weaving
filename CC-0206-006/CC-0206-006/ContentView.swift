//
//  ContentView.swift
//  CC-0206-006
//
//  Created by taeyang on 2/8/25.
//

import SwiftUI

struct ContentView: View {
    private let circleNum : Int = 10
    @State private var offsets: [(x: CGFloat, y: CGFloat)] = Array(repeating: (x: 0, y: 0), count: 10)
    
    var body: some View {
        ZStack {
            Color.gray.ignoresSafeArea()
            
            Circle()
                .fill(Color.indigo)
                .frame(width:250, height:250)
                .shadow(radius:10)
           
            ForEach(0..<circleNum, id :\.self) { i in
                MyCircle(circleWidth:100, circleHeight:100)
                    .offset(x: offsets[i].x, y: offsets[i].y)
            }
        }
        .onAppear {
            generateOffsets()
            startTimer()
        }
    }
    
    private func generateOffsets() {
        withAnimation(.easeInOut(duration:1)) {
            offsets = (0..<circleNum).map { i in
                let angle = CGFloat(i) * .pi * 2 / CGFloat(circleNum)
                let radius: CGFloat = 100 + CGFloat.random(in:-15...15)
                return (x:sin(angle) * radius, y: cos(angle)*radius)
            }
        }
    }
    
    private func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            generateOffsets()
        }
    }
}



struct MyCircle : View {
    let circleWidth: CGFloat
    let circleHeight: CGFloat
    
    var body: some View {
        
        ZStack{
            Circle()
                .stroke(
                    Color.red,
                    lineWidth: 2
                )
                .frame(width: circleWidth, height: circleHeight)
                .shadow(radius: 15)
            
            Circle()
                .foregroundStyle(Color.pink)
                .frame(width: circleWidth-30, height: circleHeight-30)
                .shadow(radius:10)
        }
    }
}

#Preview {
    ContentView()
}
