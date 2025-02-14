//
//  ContentView.swift
//  CC-CreativeCoding
//
//  Created by taeyang on 2/9/25.
//

import SwiftUI

struct MainPage: View {
    @State private var showSubButtons = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Button {
                    withAnimation {
                        showSubButtons.toggle()
                    }
                    
                } label: {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width:300, height:50)
                        .overlay(
                            Text("2025.02")
                                .foregroundColor(.white)
                        )
                        .foregroundColor(.blue)
                        .shadow(radius:5)
                }
                    if showSubButtons {
                        GeometryReader { geometry in
                            ZStack {
                                NavigationLink(destination: CC_0209_009()) {
                                    subButton(title: "0209")
                                }
                                NavigationLink(destination: CC_0210_010()) {
                                    subButton(title: "0210")
                                }
                                NavigationLink(destination: CC_0211_011()) {
                                    subButton(title: "0211")
                                }
                                NavigationLink(destination: CC_0212_012()) {
                                    subButton(title: "0212")
                                }
                                NavigationLink(destination: CC_0213_013()) {
                                    subButton(title: "0213")
                                }
                                NavigationLink(destination: CC_0214_014()) {
                                    subButton(title: "0214")
                                }
                            }
                        }
                }
            }
        }
    }
}

struct subButton : View {
    var title: String
    @State private var position: CGPoint = CGPoint(x: UIScreen.main.bounds.width/2, y: 100)
    
    var body: some View {
        Circle()
            .frame(width:100, height:100)
            .overlay(
                Text(title)
                    .foregroundStyle(.white)
            )
            .shadow(radius:3)
            .position(position)
            .onAppear {
                Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true) { _ in
                    withAnimation() {
                        position = CGPoint(x: CGFloat.random(in: 50...350), y: CGFloat.random(in:100...700))
                    }
                }
            }
    }
}

#Preview {
    MainPage()
}
