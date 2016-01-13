//
//  GameManager.swift
//  Slappy Droid
//
//  Created by Dulio Denis on 1/11/16.
//  Copyright © 2016 Dulio Denis. All rights reserved.
//

import SpriteKit

class GameManager {
    
    // GameManager is a Singleton
    static let sharedInstance = GameManager()
    
    
    // Game Constants
    let MOVEMENT_SPEED: CGFloat = -9
    
    
    // Collider Categories
    let COLLIDER_OBSTACLE: UInt32 = 1 << 0
    let COLLIDER_PLAYER  : UInt32 = 1 << 1
}
