//
//  ContentView.swift
//  CC-0204-004
//
//  Created by taeyang on 2/4/25.
//

import SwiftUI

struct ContentView: View {
    
    @State var isPressed: Bool = false
    var body: some View {
        HStack {
            VStack {
               ForEach(0..<10) { _ in
                   MyCircle(isPressed: $isPressed)
                }
            }
            VStack {
               ForEach(0..<10) { _ in
                   MyCircle(isPressed: $isPressed)
                }
            }
            VStack {
               ForEach(0..<10) { _ in
                   MyCircle(isPressed: $isPressed)
                }
            }
            VStack {
               ForEach(0..<10) { _ in
                   MyCircle(isPressed: $isPressed)
                }
            }
        }
    }
}

struct MyCircle: View {
    
    private let randomRotation = Double.random(in: 0...360)
    
    @Binding var isPressed: Bool
    @State private var rotationNumber:Double = Double.random(in: 0...360)
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 3)
                .frame(width:150, height:150)
            
            RoundedRectangle(cornerRadius: 3)
                .fill(Color.red)
                .rotationEffect(.degrees(isPressed ? randomRotation : 0))
                .frame(width:100, height:100)
            
            RoundedRectangle(cornerRadius: 3)
                .fill(Color.yellow)
                .rotationEffect(.degrees(randomRotation))
                .frame(width:60, height:60)
                .shadow(radius: 2, x:0, y:10)
            
            Button() {
                withAnimation(.spring())
                {
                    isPressed.toggle()
                }
            } label: {
                Circle()
                    .fill(Color.purple)
                    .frame(width: 50, height: 50)
            }
        }
    }
}

#Preview {
    ContentView()
}
