//
//  Obstacle.swift
//  Slappy Droid
//
//  Created by Dulio Denis on 1/10/16.
//  Copyright © 2016 Dulio Denis. All rights reserved.
//

import SpriteKit

class Obstacle: Moveable {
    
    override func startMoving() {
        super.startMoving()
        
        // Initialize Physics
        initPhysics()
    }
    
    func initPhysics() {
        physicsBody?.dynamic = false // set as static obstacles
    }
}
