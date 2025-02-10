//
//  ContentView.swift
//  CC-0203-003
//
//  Created by taeyang on 2/3/25.
//

import SwiftUI

struct ContentView: View {
    
    @State var isPressed: Bool = false
    
    var body: some View {
        VStack {
            ForEach(0..<15) { i in
                MyCircle(circleWidth: CGFloat(i+1)*10, cirlceHeight: CGFloat(i+1)*5, id:i, isPressed : $isPressed)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.gray)
    }
}

struct MyCircle : View {
    let circleWidth: CGFloat
    let cirlceHeight: CGFloat
    let id : Int
    @State var randomNum: Double = Double.random(in: 0...100)
    
    @Binding var isPressed: Bool
    
    var body: some View {
        if id == 0 {
            Button {
                withAnimation(.spring) {
                    self.isPressed.toggle()
                    randomNum = Double.random(in: 0...100)
                }
            } label : {
                Circle()
                    .fill(.gray.opacity(0.5))
                    .frame(width: 200, height: 200)
                    .shadow(color: .black
                        , radius: 10
                            , x: 0
                            , y: 10
                    )
            }
            .padding(.bottom, 50)
        } else {
            Circle()
                .fill((Color.red).opacity(0.5))
                .frame(width: circleWidth, height: cirlceHeight)
                .offset(x: isPressed ? (randomNum.remainder(dividingBy: 2.0) == 0 ? -CGFloat(randomNum) : CGFloat(randomNum)) : (randomNum.remainder(dividingBy: 2.0) == 0 ? CGFloat(randomNum) : -CGFloat(randomNum)), y: 0)
                .shadow(color: .red
                        , radius: 10
                        , x: 0
                        , y: 10
                )
        }
    }
}

#Preview {
    ContentView()
}
