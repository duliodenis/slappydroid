//
//  DroidTop.swift
//  Slappy Droid
//
//  Created by Dulio Denis on 1/19/16.
//  Copyright © 2016 Dulio Denis. All rights reserved.
//

import SpriteKit

class DroidTop: Obstacle {
    
    convenience init() {
        self.init(color: UIColor.clearColor(), size: CGSizeMake(100, 2))
        self.yPosition = 220
    }
    
    override func initPhysics() {
        physicsBody = SKPhysicsBody(rectangleOfSize: size)
        physicsBody?.categoryBitMask = GameManager.sharedInstance.COLLIDER_RIDEABLE
        zPosition = 7
        
        super.initPhysics()
    }
    
}