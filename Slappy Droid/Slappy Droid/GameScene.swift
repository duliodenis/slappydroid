//
//  GameScene.swift
//  Slappy Droid
//
//  Created by Dulio Denis on 1/4/16.
//  Copyright (c) 2016 Dulio Denis. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    // Scenery Variable & Constants
    let ASP_PIECES = 15
    let GROUND_SPEED: CGFloat = -9
    let GROUND_X_RESET: CGFloat = -150
    var asphaltPieces = [SKSpriteNode]()
    var moveGroundAction: SKAction!
    var moveGroundActionForever: SKAction!
    
    // Character Variables & Constants
    var characterPushFrames = [SKTexture]()
    let CHAR_PUSH_FRAMES = 12
    let CHAR_X_POSITION: CGFloat = 160
    let CHAR_Y_POSITION: CGFloat = 180
    var character: SKSpriteNode!
    
    override func didMoveToView(view: SKView) {
        setupBackground()
        setupGround()
        setupCharacter()
    }
   
    
    override func update(currentTime: CFTimeInterval) {
        groundMovement()
    }
    
    
    // MARK: UI Set-up Functions
    
    func setupBackground() {
        let background = SKSpriteNode(imageNamed: "bg1")
        background.position  = CGPointMake(517, 400)
        background.zPosition = 3
        addChild(background)
        
        let background2 = SKSpriteNode(imageNamed: "bg2")
        background2.position = CGPointMake(517, 450)
        background2.zPosition = 2
        addChild(background2)
        
        let background3 = SKSpriteNode(imageNamed: "bg3")
        background3.position = CGPointMake(517, 500)
        background3.zPosition = 1
        addChild(background3)
    }
    
    
    func setupGround() {
        moveGroundAction = SKAction.moveByX(GROUND_SPEED, y: 0, duration: 0.02)
        moveGroundActionForever = SKAction.repeatActionForever(moveGroundAction)
        
        for x in 0..<ASP_PIECES {
            let asp = SKSpriteNode(imageNamed: "asphalt")
            asphaltPieces.append(asp)
            
            if x == 0 {
                // if its the first one then start at the bottom left
                let start = CGPointMake(0, 144)
                asp.position = start
            } else {
                // otherwise, position it appropriately
                asp.position = CGPointMake(asp.size.width + asphaltPieces[x - 1].position.x,
                    asphaltPieces[x - 1].position.y)
            }

            asp.runAction(moveGroundActionForever)
            addChild(asp)
        }
    }
    
    
    // MARK: Ground Function
    
    func groundMovement() {
        for x in 0..<ASP_PIECES {
            if asphaltPieces[x].position.x <= GROUND_X_RESET {
                var index: Int!
                if x == 0 {
                    index = asphaltPieces.count - 1
                } else {
                    index = x - 1
                }
                
                let newPosition = CGPointMake(asphaltPieces[index].position.x + asphaltPieces[x].size.width, asphaltPieces[x].position.y)
                asphaltPieces[x].position = newPosition
            }
        }
    }
    
    
    // MARK: Character Functions
    
    func setupCharacter() {
        for x in 0 ..< CHAR_PUSH_FRAMES {
            characterPushFrames.append(SKTexture(imageNamed: "push\(x)"))
        }
        
        character = SKSpriteNode(texture: characterPushFrames[0])
        character.position = CGPointMake(CHAR_X_POSITION, CHAR_Y_POSITION)
        character.zPosition = 10
        character.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(characterPushFrames, timePerFrame: 0.1)))
        
        addChild(character)
    }
}
