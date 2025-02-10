//
//  ContentView.swift
//  CC-0208-008
//
//  Created by taeyang on 2/8/25.
//

import SwiftUI

struct ContentView: View {
    let colums: [GridItem] = Array(repeating: .init(.flexible()), count:20)
    @State private var randomText: [String] = Array(repeating:"", count:400)
    @State private var colors:[Color] = Array(repeating:.white, count:400)
    
    let koreanCharacters: [String] = ["ㄱ", "ㄴ", "ㄷ", "ㄹ", "ㅁ", "ㅅ", "ㅈ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"]
    
    var body: some View {
        GeometryReader { geometry in
            let cellSize = max(geometry.size.width / 20, geometry.size.height / 20)
            
            LazyVGrid(columns: colums, spacing: 1) {
                ForEach(0..<randomText.count, id: \.self) { index in
                    Text(randomText[index])
                        .font(.system(size: cellSize * 0.8, weight:.bold, design: .monospaced))
                        .frame(width:cellSize, height:cellSize)
                        .foregroundColor(colors[index])
                }
            }
            .frame(width:geometry.size.width, height: geometry.size.height)
            .background(Color.black)
            .onAppear {
                startAnimation()
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    func startAnimation() {
        for i in 0..<randomText.count {
            let delay = Double(i/20) * 0.1 + Double(i % 20) * 0.05
            
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                randomText[i] = koreanCharacters.randomElement() ?? ""
                colors[i] = Color(hue: Double.random(in:0...1), saturation: 1, brightness: 1)
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation(.easeInOut(duration: 0.5)) {
                    colors[i] = .white
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
