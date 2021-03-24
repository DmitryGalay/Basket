//
//  GameScene.swift
//  ring2test
//
//  Created by Dima on 5/15/20.
//  Copyright © 2020 Dima. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    private enum zposition: CGFloat{
        case checkOver = 11
        case background = 2
        case border = 3
        case contactBall = 4
        case ring = 5
        case ball = 6
        case gameOver = 7
        case ringBall = 8
        case scoreBackground = 9
        case score = 10
    }
    var gameViewController: GameViewControllerProtocol?
    var ball = SKSpriteNode(imageNamed: "ball")
    var ball2 = SKShapeNode(circleOfRadius: 10)
    var ball3 = SKShapeNode(circleOfRadius: 10)
    var ball4 = SKShapeNode(circleOfRadius: 0.1)
    var ball5 = SKShapeNode(circleOfRadius: 0.1)
    var ball6 = SKShapeNode(circleOfRadius: 0.1)
    var ball7 = SKShapeNode(circleOfRadius: 0.1)
    var touch: Bool = false
    var touch2: Bool = false
    let line = SKShapeNode()
    let line2 = SKShapeNode()
    var ring = SKSpriteNode()
    var score = NSInteger()
    var scoreLabel = SKLabelNode(fontNamed: "ScoreBackground")
    var scoreBackground = SKSpriteNode(imageNamed: "raitingBackground")
    var background1 = SKSpriteNode(imageNamed: "background_game")
    var background2 = SKSpriteNode(imageNamed: "background_game")
    var upBorder = SKSpriteNode(imageNamed: "upBorder")
    var downBorder = SKSpriteNode(imageNamed: "downBorder")
    let path = CGMutablePath()
    let checkOver = SKShapeNode()
    var positionY = [CGPoint]()
    let ballCategory: UInt32 = 1 << 0
    let ringCategory: UInt32 = 1 << 1
    let scoreCategory: UInt32 = 1 << 2
    let borderCategory: UInt32 = 1 << 3
    let contactBallCategory: UInt32 = 1 << 4
    let contact2BallCategory: UInt32 = 1 << 5
    let checkOverCategory: UInt32 = 1 << 0
    
    
    override func didMove(to view: SKView) {
       
        self.physicsWorld.gravity = CGVector( dx: 0.0, dy: -4.0 )
        self.physicsWorld.contactDelegate = self
        self.anchorPoint = CGPoint(x: 0, y: 0)
        greatScore()
        greatBackground()
        greatRing()
        greatBall()
        greatUpBorder()
        greatDownBorder()
    }
    
    func greatScore() {
        scoreLabel.text = "\(score)"
        scoreLabel.zPosition = zposition.score.rawValue
        scoreLabel.fontSize = 40
        scoreLabel.fontColor = SKColor.white
        scoreLabel.position = CGPoint(x: self.frame.midX, y: self.frame.midY +  self.frame.midY / 3 + self.frame.midY / 2.3)
        addChild(scoreLabel)
        scoreBackground.zPosition = zposition.scoreBackground.rawValue
        scoreBackground.position = CGPoint(x: self.frame.midX , y:self.frame.midY +  self.frame.midY / 3 + self.frame.midY / 2.3 + self.frame.midY / 22)
        addChild(scoreBackground)
    }
    
    func greatRing() {
        ring.name = "ring"
        ring.physicsBody?.isDynamic = false
        ring.size = CGSize(width: 120, height: 80)
        ring.zPosition = zposition.ring.rawValue
        ring.physicsBody?.categoryBitMask = ringCategory
        ring.physicsBody?.contactTestBitMask =  ballCategory | checkOverCategory
        ring.physicsBody?.collisionBitMask = checkOverCategory
        addChild(ring)
        ball2.name = "ball2"
        ball2.position = CGPoint( x: 0, y:-30 )
        ball2.glowWidth = 5.0
        ball2.fillColor = .white
        ball2.physicsBody = SKPhysicsBody(circleOfRadius: 40)
        ball2.physicsBody?.isDynamic = false
        ball2.zPosition = zposition.ringBall.rawValue
        ball2.physicsBody?.categoryBitMask = ringCategory
        ring.addChild(ball2)
        ball3.position = CGPoint(x:Int(ring.size.width), y: -30)
        ball3.name = "ball3"
        ball3.glowWidth = 5.0
        ball3.fillColor = .white
        ball3.physicsBody = SKPhysicsBody(circleOfRadius: 40)
        ball3.physicsBody?.isDynamic = false
        ball3.zPosition = zposition.ringBall.rawValue
        ball3.physicsBody?.categoryBitMask = ringCategory
        ring.addChild(ball3)
        ball4.position = CGPoint(x:Int(ring.size.width / 2), y: -28)
        ball4.name = "ball4"
        ball4.fillColor = .orange
        ball4.physicsBody = SKPhysicsBody(circleOfRadius: 40)
        ball4.physicsBody?.isDynamic = false
        ball4.zPosition = zposition.contactBall.rawValue
        ball4.physicsBody?.categoryBitMask = contactBallCategory
        ring.addChild(ball4)
        
        ball5.position = CGPoint(x:Int(ring.size.width / 2), y: -32)
        ball5.name = "ball5"
        ball5.fillColor = .red
        ball5.physicsBody = SKPhysicsBody(circleOfRadius: 40)
        ball5.physicsBody?.isDynamic = false
        ball5.zPosition = zposition.contactBall.rawValue
        ball5.physicsBody?.categoryBitMask = contact2BallCategory
        ring.addChild(ball5)
        
        path.addLines(between: [ball2.position, ball3.position])
        line.path = path
        line.zPosition = zposition.ring.rawValue
        line.strokeColor = .orange
        line.lineWidth = 10
        ring.addChild(line)
        
        let moveLine = SKAction.move(by: CGVector(dx: -self.size.width , dy:0 ), duration: 6)
        let repeatLine = SKAction.repeatForever(moveLine)
        ring.run(moveLine)
        ring.run(repeatLine)
    }
    
    func greatUpBorder() {
        upBorder.name = "upBorder"
        upBorder.physicsBody = SKPhysicsBody(rectangleOf: upBorder.size)
        upBorder.physicsBody?.isDynamic = false
        upBorder.size.width = self.size.width
        upBorder.zPosition = zposition.border.rawValue
        upBorder.position = CGPoint(x: upBorder.size.width / 2, y:self.frame.size.height - downBorder.size.height / 2)
        upBorder.physicsBody?.categoryBitMask = borderCategory
        upBorder.physicsBody?.contactTestBitMask = ballCategory
        upBorder.physicsBody?.collisionBitMask = ballCategory
        addChild(upBorder)
    }
    
    func greatDownBorder() {
        downBorder.name = "downBorder"
        downBorder.physicsBody = SKPhysicsBody(rectangleOf: upBorder.size)
        downBorder.physicsBody?.isDynamic = false
        downBorder.size.width = self.size.width
        downBorder.zPosition = zposition.border.rawValue
        downBorder.position = CGPoint(x: downBorder.size.width / 2, y:downBorder.size.height / 2)
        downBorder.physicsBody?.categoryBitMask = borderCategory
        downBorder.physicsBody?.contactTestBitMask = ballCategory
        downBorder.physicsBody?.collisionBitMask = ballCategory
        addChild(downBorder)
    }
    
    func greatBackground() {
        background1.position = CGPoint(x: self.frame.midX , y:self.frame.midY)
        background1.zPosition = zposition.background.rawValue
        background1.size.width = self.size.width
        background1.size.height = self.size.height
        addChild(background1)
        background2.position = CGPoint(x: self.frame.midX  + background1.size.width , y:self.frame.midY)
        background2.zPosition = zposition.background.rawValue
        background2.size = UIScreen.main.bounds.size
        background2.size.width = self.size.width
        background2.size.height = self.size.height
        addChild(background2)
        moveBackground()
    }
    
    func moveBackground() {
        let moveBackground = SKAction.move(by: CGVector(dx: -self.size.width  , dy:0 ), duration: 4 )
        let repeatBackground = SKAction.repeatForever(moveBackground)
        background1.run(repeatBackground)
        background2.run(repeatBackground)
    }
    
    func greatBall() {
        ball.name = "ball"
        ball.physicsBody?.isDynamic = true
        ball.physicsBody?.affectedByGravity = true
        ball.zPosition = zposition.ball.rawValue
        ball.physicsBody?.usesPreciseCollisionDetection = true
        ball.position = CGPoint(x: self.frame.midX, y: self.frame.midY + self.frame.midY/2)
        ball.physicsBody = SKPhysicsBody(circleOfRadius: 30)
        ball.physicsBody?.restitution = 0.4
        ball.physicsBody?.categoryBitMask = ballCategory
        ball.physicsBody?.contactTestBitMask = contactBallCategory  | borderCategory | contact2BallCategory
        ball.physicsBody?.collisionBitMask = borderCategory
        ball.physicsBody?.allowsRotation = true
        self.addChild(ball)
    }
    
    func resetScene (){
        ball.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        ring.position.x =  -background1.size.width
        ball.physicsBody?.velocity = CGVector( dx: 0, dy: 0 )
        upBorder.removeAllChildren()
        downBorder.removeAllChildren()
        ring.removeAllChildren()
        ball.removeAllChildren()
        score = 0
        scoreLabel.text = "0"
        self.physicsWorld.gravity = CGVector( dx: 0.0, dy: -4.0 )
        self.physicsWorld.contactDelegate = self
        self.anchorPoint = CGPoint(x: 0, y: 0)
        greatRing()
        greatBall()
        moveBackground()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for _ in touches {
            ball.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 30))
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        background1.position = CGPoint(x: background1.position.x, y: background1.position.y)
        background2.position = CGPoint(x: background2.position.x, y: background2.position.y)
        
        if (background1.position.x < -background1.size.width / 2) {
            background1.position = CGPoint(x:background2.position.x + background2.size.width, y:background2.position.y )
        }
        if (background2.position.x < -background2.size.width / 2 ) {
            background2.position = CGPoint(x:background1.position.x + background1.size.width , y:background1.position.y )
        }
        if ring.position.x <  -background1.size.width / 2 {
            ring.position = CGPoint(x: self.frame.size.width, y: self.frame.midY)
            ring.run(SKAction.fadeIn(withDuration: 2))
            positionY.append(CGPoint(x: ring.position.x,  y: ring.position.y + frame.size.height / 8))
            positionY.append(CGPoint(x: ring.position.x,  y: ring.position.y + frame.size.height / 5 ))
            positionY.append(CGPoint(x: ring.position.x,  y: ring.position.y ))
            positionY.append(CGPoint(x: ring.position.x,  y: ring.position.y - frame.size.height / 5))
            positionY.append(CGPoint(x: ring.position.x,  y: ring.position.y - frame.size.height / 8 ))
            let count = Int(arc4random_uniform(UInt32(positionY.count)))
            let positionRing = positionY[count] as CGPoint
            ring.position = positionRing
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
    
        if contact.bodyB.categoryBitMask  == ballCategory &&
            contact.bodyA.categoryBitMask  == contactBallCategory {
            touch = true
        }
        if contact.bodyB.categoryBitMask  == ballCategory &&
            contact.bodyA.categoryBitMask  == contact2BallCategory {
            touch2 = true
            if touch == true {
                touch2 = true
                score += 1
                ring.run(SKAction.fadeOut(withDuration: 1))
                VibrationManager.shared.lightImpact()
                scoreLabel.text = "\(score)"
            }
            if touch == false  {
                if score > GameLogic.shared.score{
                               GameLogic.shared.score = score
                               gameViewController?.showWinController()
                           }else{
                               gameViewController?.showLoseController()
                           }
                       }
            touch = false
            
        }
    
        if  contact.bodyB.categoryBitMask  == ballCategory &&
            contact.bodyA.categoryBitMask  == borderCategory {
            VibrationManager.shared.cancelVibration()
            ball.removeFromParent()
            background1.removeAllActions()
            background2.removeAllActions()
            ring.removeFromParent()
            ball.removeAllActions()
            ring.removeAllActions()
            score = 0
            if score > GameLogic.shared.score{
                GameLogic.shared.score = score
                gameViewController?.showWinController()
            }else{
                gameViewController?.showLoseController()
            }
        }
    
    }
}
   

