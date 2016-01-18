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
        let topCollider = SKPhysicsBody(rectangleOfSize: CGSizeMake(size.width * 0.80, 5), center: CGPointMake(0, (size.height / 2) - 7))
        
        physicsBody = SKPhysicsBody(bodies: [frontCollider, topCollider])
        zPosition = 5
        super.initPhysics()
    }
    
}
