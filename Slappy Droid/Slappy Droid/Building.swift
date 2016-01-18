//
//  Building.swift
//  Slappy Droid
//
//  Created by Dulio Denis on 1/18/16.
//  Copyright © 2016 Dulio Denis. All rights reserved.
//

import SpriteKit

class Building: Moveable {
    
    convenience init() {
        self.init(imageNamed: "building\(arc4random_uniform(8))")
        anchorPoint = CGPointMake(0.5, 0)
        self.yPosition = 200
        self.zPosition = 4
    }
    
    
    override func didExceedBounds() {
        super.didExceedBounds()
        self.texture = SKTexture(imageNamed: "building\(arc4random_uniform(8))")
    }
}