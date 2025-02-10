//
//  ContentView.swift
//  CC-0205-005
//
//  Created by taeyang on 2/5/25.
//

import SwiftUI

struct ContentView: View {
    @State private var phase: CGFloat = 0
    var body: some View {
        VStack {
            Button {
                withAnimation(.bouncy(duration: 1)) {
                    phase += .pi * 0.1
                }
            } label : {
                Image(systemName: "heart.fill")
                    .font(.system(size: 300))
                    .foregroundStyle(.black)
            }
            
            ForEach(0..<10, id: \.self) { index in
                Image(systemName: "heart.fill")
                    .font(.system(size: 30))
                    // sin(phase + index)로 계산한 값에 곱해진 amplitude(여기서는 50)를 x축 오프셋으로 적용
                    .offset(x: sin(phase + CGFloat(index) * 0.5) * 50)
            }

            ZStack {
                Image(systemName: "heart.fill")
                    .font(.system(size: 100))
                
                Image(systemName: "heart.fill")
                    .font(.system(size: 200))
                    .opacity(0.5)
                }
            
                }
            }
}


#Preview {
    ContentView()
}
