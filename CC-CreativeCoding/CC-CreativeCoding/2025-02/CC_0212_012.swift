//
//  CC_0212_012.swift
//  CC-CreativeCoding
//
//  Created by taeyang on 2/12/25.
//

import SwiftUI
import SpriteKit


struct CC_0212_012: View {
    
    var scene: SKScene {
        let scene = SKScene(size: CGSize(width: 800, height: 1600))
        scene.backgroundColor = .white
        
        scene.physicsWorld.gravity = CGVector(dx:0, dy:-9.8)
        
        let ground = SKSpriteNode(color:.white, size:CGSize(width:400, height:50))
        ground.position = CGPoint(x:scene.size.width/2, y:300)
        ground.color = .blue
        ground.zRotation = .pi
        ground.physicsBody = SKPhysicsBody(rectangleOf: ground.size)
        ground.physicsBody?.isDynamic = false
        
        let rotationAction = SKAction.rotate(byAngle: .pi * 2, duration: 5)
        ground.run(rotationAction)
        
        scene.addChild(ground)
        
        let ball = SKShapeNode(circleOfRadius: 40)
        ball.fillColor = .green
        ball.position = CGPoint(x:scene.size.width/2, y:scene.size.height - 100)
        ball.physicsBody = SKPhysicsBody(circleOfRadius: 40)
        ball.physicsBody?.restitution = 0.8
        scene.addChild(ball)
        
        return scene
    }
    
    var body: some View {
        SpriteView(scene: scene)
    }
}

#Preview {
    CC_0212_012()
}
