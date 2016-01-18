//
//  GameScene.swift
//  Slappy Droid
//
//  Created by Dulio Denis on 1/4/16.
//  Copyright (c) 2016 Dulio Denis. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    // MARK: Scenery Variable & Constants
    let ASP_PIECES = 15
    let SIDEWALK_PIECES = 24
    let GROUND_X_RESET: CGFloat = -150
    var asphaltPieces = [SKSpriteNode]()
    var sidewalkPieces = [SKSpriteNode]()
    var buildings = [SKSpriteNode]()
    
    // Background Arrays for parallaxing
    var farBackground = [SKSpriteNode]()
    var midBackground = [SKSpriteNode]()
    var nearBackground = [SKSpriteNode]()
    var backgroundActions = [SKAction]()
    let BACKGROUND_X_RESET: CGFloat = -912.0
    
    var moveGroundAction: SKAction!
    var moveGroundActionForever: SKAction!
    
    var player: Player!
    
    
    // MARK: Scene Lifecycle
    
    override func didMoveToView(view: SKView) {
        setupBackground()
        setupGround()
        setupSidewalk()
        setupBuildings()
        setupPlayer()
        setupGestures()
        setupDroid()
        setupWorld()
    }
   
    
    override func update(currentTime: CFTimeInterval) {
        groundMovement()
        sidewalkMovement()
        backgroundMovement()
        updateChildren()
    }
    
    
    // call the update function of each child
    func updateChildren() {
        for child in children {
            child.update()
        }
    }
    
    
    // MARK: UI Set-up Functions
    
    func setupBackground() {
        for i in 0..<3 {
            addBackground("bg1", index: i, imageWidth: 400, zPosition: 3, velocity: -2.0)
            addBackground("bg2", index: i, imageWidth: 450, zPosition: 2, velocity: -1.0)
            addBackground("bg3", index: i, imageWidth: 500, zPosition: 1, velocity: -0.5)
        }
    }
    
    
    func addBackground(imageName: String!, index: Int, imageWidth: CGFloat, zPosition: CGFloat, velocity: CGFloat) {
        let background = SKSpriteNode(imageNamed: imageName)
        background.position  = CGPointMake(CGFloat(index) * background.size.width, imageWidth)
        background.zPosition = zPosition
        let action: SKAction = SKAction.repeatActionForever(SKAction.moveByX(velocity, y: 0, duration: 0.02))
        background.runAction(action)
        backgroundActions.append(action)
        addChild(background)
        
        if imageName == "bg1" { nearBackground.append(background) }
        if imageName == "bg2" { midBackground.append(background) }
        if imageName == "bg3" { farBackground.append(background) }
    }
    
    
    func setupGround() {
        moveGroundAction = SKAction.moveByX(GameManager.sharedInstance.MOVEMENT_SPEED, y: 0, duration: 0.02)
        moveGroundActionForever = SKAction.repeatActionForever(moveGroundAction)
        
        for x in 0..<ASP_PIECES {
            let asp = SKSpriteNode(imageNamed: "asphalt")
            
            // Add a static physics body as a ground collider
            let groundCollider = SKPhysicsBody(rectangleOfSize: CGSizeMake(asp.size.width, 5), center: CGPointMake(0, -20))
            groundCollider.dynamic = false
            asp.physicsBody = groundCollider
            
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
    
    
    func setupSidewalk() {
        for x in 0..<SIDEWALK_PIECES {
            let piece = SKSpriteNode(imageNamed: "sidewalk")
            
            sidewalkPieces.append(piece)
            
            if x == 0 {
                // if its the first one then start at the bottom left
                let start = CGPointMake(0, 190)
                piece.position = start
            } else {
                // otherwise, position it appropriately
                piece.position = CGPointMake(piece.size.width + sidewalkPieces[x - 1].position.x,
                    sidewalkPieces[x - 1].position.y)
            }
            
            piece.zPosition = 5
            piece.runAction(moveGroundActionForever)
            addChild(piece)
        }
    }
    
    
    func setupBuildings() {
        for i in 0..<3 {
            let wait = SKAction.waitForDuration(2.0 * Double(i))
            
            runAction(wait, completion: { () -> Void in
                let building = Building()
                self.buildings.append(building)
                self.addChild(building)
                building.startMoving()
            })
        }
    }
    
    
    func setupPlayer() {
        player = Player()
        addChild(player)
    }
    
    
    func setupDroid() {
        let droid = Droid()
        droid.startMoving()
        addChild(droid)
    }
    
    
    // do any world environmental variable setting
    func setupWorld() {
        physicsWorld.gravity = CGVectorMake(0, -10)
        physicsWorld.contactDelegate = self
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
        
    
    func sidewalkMovement() {
        for x in 0..<SIDEWALK_PIECES {
            if sidewalkPieces[x].position.x <= GROUND_X_RESET {
                var index: Int!
                if x == 0 {
                    index = sidewalkPieces.count - 1
                } else {
                    index = x - 1
                }
                
                let newPosition = CGPointMake(sidewalkPieces[index].position.x + sidewalkPieces[x].size.width, sidewalkPieces[x].position.y)
                sidewalkPieces[x].position = newPosition
            }
        }
    }
    
    
    func backgroundMovement() {
        for i in 0..<3 {
            setPosition(farBackground,  index: i, resetValue: BACKGROUND_X_RESET)
            setPosition(midBackground,  index: i, resetValue: BACKGROUND_X_RESET)
            setPosition(nearBackground, index: i, resetValue: BACKGROUND_X_RESET)
        }
    }
    
    
    func setPosition(imageArray: [SKSpriteNode], index: Int, resetValue: CGFloat) {
        if imageArray[index].position.x <= resetValue {
            var i: Int!
            if index == 0 {
                i = imageArray.count - 1
            } else {
                i = index - 1
            }
            
            let newPosition = CGPointMake(imageArray[i].position.x + imageArray[index].size.width, imageArray[index].position.y)
            imageArray[index].position = newPosition
        }
    }
    
    
    // MARK: Gesture Recognizer Functions
    
    func setupGestures() {
        let tap = UITapGestureRecognizer(target: self, action: "tapped:")
        tap.allowedPressTypes = [NSNumber(integer: UIPressType.Select.rawValue)]
        view?.addGestureRecognizer(tap)
    }
    
    
    func tapped(gesture: UIGestureRecognizer) {
        player.jump()
    }
    
    
    // MARK: Collision Handling
    
    func didBeginContact(contact: SKPhysicsContact) {
        if contact.bodyA.categoryBitMask == GameManager.sharedInstance.COLLIDER_OBSTACLE ||
           contact.bodyB.categoryBitMask == GameManager.sharedInstance.COLLIDER_OBSTACLE {
            print("Hit a droid")
        }
    }
}
