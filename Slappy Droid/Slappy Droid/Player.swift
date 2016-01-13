//
//  Player.swift
//  Slappy Droid
//
//  Created by Dulio Denis on 1/11/16.
//  Copyright © 2016 Dulio Denis. All rights reserved.
//

import SpriteKit

class Player: SKSpriteNode {
    
    // MARK: Character Variables & Constants
    var characterPushFrames = [SKTexture]()
    let CHAR_PUSH_FRAMES = 12
    let CHAR_X_POSITION: CGFloat = 160
    let CHAR_Y_POSITION: CGFloat = 180
    var isJumping = false // Is the character in a jump state
    
    
    convenience init() {
        self.init(imageNamed: "push0")
        setupCharacter()
    }
    
    
    func setupCharacter() {
        for x in 0 ..< CHAR_PUSH_FRAMES {
            characterPushFrames.append(SKTexture(imageNamed: "push\(x)"))
        }
        
        position = CGPointMake(CHAR_X_POSITION, CHAR_Y_POSITION)
        zPosition = 10
        runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(characterPushFrames, timePerFrame: 0.1)))
        
        // Set a front and bottom collider for the character
        let fronColliderSize = CGSizeMake(5, size.height * 0.80) // 80% the height of the character
        let frontCollider = SKPhysicsBody(rectangleOfSize: fronColliderSize, center: CGPointMake(25, 0))
        
        let bottomColliderSize = CGSizeMake(size.width / 2, 5) // half the width of the character
        let bottomCollider = SKPhysicsBody(rectangleOfSize: bottomColliderSize, center: CGPointMake(0, -50))
        
        physicsBody = SKPhysicsBody(bodies: [frontCollider, bottomCollider])
        
        // Physics on Character and World
        physicsBody?.restitution = 0 // character has no bounciness
        physicsBody?.linearDamping = 0.1 // no friction
        physicsBody?.allowsRotation = false // no automatic rotation
        physicsBody?.mass = 0.1
        physicsBody?.dynamic = true // automatically moved with colliders
        
        // Define Collision Category
        physicsBody?.categoryBitMask = GameManager.sharedInstance.COLLIDER_PLAYER
        physicsBody?.contactTestBitMask = GameManager.sharedInstance.COLLIDER_OBSTACLE
    }
    
    
    func jump() {
        if !isJumping {
            isJumping = true
            let impulseHorizontal: CGFloat = 0.0
            let impulseVertical: CGFloat =  60.0
            physicsBody?.applyImpulse(CGVectorMake(impulseHorizontal, impulseVertical))
        }
    }
    
    
    override func update() {
        // if character stopped moving then allow it to jump again
        if isJumping {
            if floor(physicsBody!.velocity.dy) == 0 {
                isJumping = false // reset the jump state
            }
        }
        super.update()
    }
}
