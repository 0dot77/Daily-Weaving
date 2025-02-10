//
//  ContentView.swift
//  CC-0201-001
//
//  Created by taeyang on 2/1/25.
//

import SwiftUI

struct ContentView: View {
    // 버튼이 눌린 상태를 나타내는 변수
    @State private var isPressed: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                Button {
                    // 버튼 액션은 여기서 비워두고 제스처로 상태 관리를 합니다.
                } label: {
                    Circle()
                        .frame(width: 250, height: 250)
                        .foregroundStyle(.black)
                }
                // DragGesture를 이용해 버튼을 누르고 있는 동안 isPressed를 true로, 터치가 끝나면 false로 설정
                .simultaneousGesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { _ in
                            isPressed = true
                        }
                        .onEnded { _ in
                            isPressed = false
                        }
                )
                
                Spacer()
            }
            
            // 버튼이 눌려 있는 동안 오버레이로 빗방울 애니메이션 뷰를 표시
            if isPressed {
                RainEffectView()
                    // 부드러운 전환 효과 (옵션)
                    .transition(.opacity)
                    .animation(.easeInOut, value: isPressed)
            }
        }
    }
}

struct RainEffectView: View {
    // 화면 크기를 활용하기 위해 UIScreen 사용 (또는 GeometryReader 사용 가능)
    let screenWidth = UIScreen.main.bounds.width
    
    // 생성할 빗방울의 개수 (필요에 따라 조정)
    let numberOfDrops = 30
    
    var body: some View {
        ZStack {
            ForEach(0..<numberOfDrops, id: \.self) { _ in
                RainDrop()
            }
        }
        .ignoresSafeArea() // 빗방울이 전체 화면을 덮도록 설정
    }
}

struct RainDrop: View {
    // 빗방울의 애니메이션 상태 및 랜덤 속성을 위한 상태 변수들
    @State private var yPosition: CGFloat = -50
    private let screenHeight = UIScreen.main.bounds.height
    private let xPosition: CGFloat = CGFloat.random(in: 0...UIScreen.main.bounds.width)
    private let delay: Double = Double.random(in: 0...1)
    private let dropLength: CGFloat = CGFloat.random(in: 10...20)
    
    var body: some View {
        Rectangle()
            .fill(Color.blue)
            .frame(width: 2, height: dropLength)
            // 초기 위치는 화면 상단 바깥 (-50)
            .position(x: xPosition, y: yPosition)
            .onAppear {
                // 애니메이션 시작: 화면 하단 바깥까지 내려가도록 애니메이션 적용
                withAnimation(
                    Animation.linear(duration: 2)
                        .delay(delay)
                        .repeatForever(autoreverses: false)
                ) {
                    yPosition = screenHeight + 50
                }
            }
    }
}

#Preview {
    ContentView()
}
