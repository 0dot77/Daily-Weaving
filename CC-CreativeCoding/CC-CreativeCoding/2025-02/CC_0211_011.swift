//
//  CC_0211_011.swift
//  CC-CreativeCoding
//
//  Created by taeyang on 2/12/25.
//

import SwiftUI

struct CC_0211_011: View {
    @State var firstGridNum : Int = 1
                                   
    var body: some View {
        Grid() {
            GridRow {
                ForEach(0..<firstGridNum, id:\.self) { _ in Color.red}
                    .frame(width: 50, height: 50)
            }
            GridRow {
                ForEach(0..<5) { _ in Color.green}
                ForEach(0..<firstGridNum, id:\.self) { _ in Color.red}
                    .frame(width: 50, height: 100)
            }
            GridRow {
                ForEach(0..<firstGridNum, id:\.self) { _ in Color.red}
                ForEach(0..<10) { _ in Color.blue}
            }
        }
        .frame(width:.infinity, height:.infinity)
        .background(.black)
        .onReceive(Timer.publish(every:1.0, on:.main, in: .common).autoconnect()) { _ in
            self.firstGridNum = Int(Double.random(in: 1...10))
        }
    }
}

#Preview {
    CC_0211_011()
}
