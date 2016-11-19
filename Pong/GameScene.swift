//
//  GameScene.swift
//  Pong
//
//  Created by Greg Mor Bacskai on 19/11/16.
//  Copyright © 2016 bacskai. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var ball = SKSpriteNode()
    var player = SKSpriteNode()
    var enemy = SKSpriteNode()
    var score = [Int]()
    var gameStatusLabel = SKLabelNode()
    
    enum ColliderType: UInt32 {
        case Ball = 2
        case PlayerGoalLine = 4
        case EnemyGoalLine = 5
    }
    
    override func didMove(to view: SKView) {
        startGame()
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        player = self.childNode(withName: "player") as! SKSpriteNode
        enemy = self.childNode(withName: "enemy") as! SKSpriteNode
        
        //let ballDirectionX = Int(arc4random_uniform(30)+10)
        //let ballDirectionY = Int(arc4random_uniform(30)+10)
        ball.physicsBody!.applyImpulse(CGVector(dx: -20, dy: 20))
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0
        border.restitution = 1
        self.physicsBody = border
        
        gameStatusLabel.text = "\(score[0]) : \(score[1])"
        gameStatusLabel.fontSize = 100
        gameStatusLabel.alpha = 0.4
        gameStatusLabel.position = CGPoint(x: 0, y: 0)
        self.addChild(gameStatusLabel)
    }
    
    func startGame(){
        score = [0,0]
    }
    
    func addScoreFor(winner: SKSpriteNode){
        ball.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        if winner == player{
            score[0] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: 20, dy: 20))
            
        }
        else if winner == enemy{
            score[1] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: -20, dy: 20))
        }
        gameStatusLabel.text = "\(score[0]) : \(score[1])"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let location = touches.first?.location(in: self){
            player.run(SKAction.moveTo(x: location.x, duration: 0.15555))
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let location = touches.first?.location(in: self){
            player.run(SKAction.moveTo(x: location.x, duration: 0.15555))
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.15555))
        if ball.position.y > enemy.position.y {
            addScoreFor(winner: player)
        }
        else if ball.position.y < player.position.y {
            addScoreFor(winner: enemy)
        }
    }
}
