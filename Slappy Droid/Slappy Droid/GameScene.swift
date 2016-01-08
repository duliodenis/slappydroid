//
//  GameScene.swift
//  Slappy Droid
//
//  Created by Dulio Denis on 1/4/16.
//  Copyright (c) 2016 Dulio Denis. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    let ASP_PIECES = 15
    var asphaltPieces = [SKSpriteNode]()
    
    
    override func didMoveToView(view: SKView) {
        setupBackground()
        setupGround()
    }
   
    
    override func update(currentTime: CFTimeInterval) {

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
            
            addChild(asp)
        }
    }
}
