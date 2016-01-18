//
//  Moveable.swift
//  Slappy Droid
//
//  Created by Dulio Denis on 1/17/16.
//  Copyright © 2016 Dulio Denis. All rights reserved.
//

import SpriteKit

class Moveable: SKSpriteNode {
    
    // MARK: Obstacle Constants
    
    static let RESET_X_POSITION: CGFloat = -800
    static let START_X_POSITION: CGFloat = 1800
    
    var yPosition: CGFloat = 0
    
    
    // MARK: Obstacle Actions
    
    var moveAction: SKAction!
    var moveForever: SKAction!
    
    
    // MARK: Movement Function
    
    func startMoving() {
        // Set the starting position
        position = CGPointMake(Moveable.START_X_POSITION, yPosition)
        
        // Establish the movement action - equivalent to the ground
        moveAction = SKAction.moveByX(GameManager.sharedInstance.MOVEMENT_SPEED, y: 0, duration: 0.02)
        moveForever = SKAction.repeatActionForever(moveAction)
        
        runAction(moveForever)
    }
    
    
    override func update() {
        if position.x <= Moveable.RESET_X_POSITION {
            didExceedBounds()
        }
    }
    
    
    // MARK: Bounds Function
    
    func didExceedBounds() {
        position = CGPointMake(Moveable.START_X_POSITION, position.y)
    }
}
