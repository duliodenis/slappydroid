//
//  Droid.swift
//  Slappy Droid
//
//  Created by Dulio Denis on 1/10/16.
//  Copyright © 2016 Dulio Denis. All rights reserved.
//

import SpriteKit

class Droid: Obstacle {
    
    convenience init() {
        self.init(imageNamed: "droid3")
        self.yPosition = 180
    }
    
    
    override func initPhysics() {
        let frontCollider = SKPhysicsBody(rectangleOfSize: CGSizeMake(5, size.height), center: CGPointMake(-size.width/2, 0))
        
        // Define Collision Category
        frontCollider.categoryBitMask = GameManager.sharedInstance.COLLIDER_OBSTACLE
        frontCollider.contactTestBitMask = GameManager.sharedInstance.COLLIDER_PLAYER
        
        physicsBody = frontCollider
        zPosition = 5
        super.initPhysics()
    }
    
}
