//
//  Obstacle.swift
//  Slappy Droid
//
//  Created by Dulio Denis on 1/10/16.
//  Copyright © 2016 Dulio Denis. All rights reserved.
//

import SpriteKit

class Obstacle: SKSpriteNode {
    
    // MARK: Obstacle Constants
    
    static let RESET_X_POSITION: CGFloat = -800
    static let START_X_POSITION: CGFloat = 1800
    
    
    // MARK: Obstacle Actions
    
    var moveAction: SKAction!
    var moveForever: SKAction!
    
    
    // MARK: Movement Function
    
    func startMoving() {
        // Set the starting position
        position = CGPointMake(Obstacle.START_X_POSITION, 180)
        
        // Establish the movement action - equivalent to the ground
        moveAction = SKAction.moveByX(-8.5, y: 0, duration: 0.02)
        moveForever = SKAction.repeatActionForever(moveAction)
        
        // Mid Layer
        zPosition = 7
        
        // Initialize Physics
        initPhysics()
        
        runAction(moveForever)
    }
    
    
    override func update() {
        if position.x <= Obstacle.RESET_X_POSITION {
            position = CGPointMake(Obstacle.START_X_POSITION, position.y)
        }
    }
    
    
    func initPhysics() {
        physicsBody?.dynamic = false // set as static obstacles
    }
}
