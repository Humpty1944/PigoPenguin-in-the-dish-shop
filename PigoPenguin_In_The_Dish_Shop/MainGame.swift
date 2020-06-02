

import UIKit
import SpriteKit
import CoreMotion
import GameplayKit

struct ColliderType{
    static let Player: UInt32 = 1
    static let Objects: UInt32 = 2
}

class MainGame: SKScene,SKPhysicsContactDelegate {
    let motionManager = CMMotionManager();
    var counter=0
    
    var time=0
    var transition:SKTransition = SKTransition.push(with: SKTransitionDirection.up, duration: 1)
    var mainGame:SKScene!
   // var timeCount=Timer()
    var timeCountForResult=Timer()
    var labelScore: SKLabelNode!
    var player: SKSpriteNode?
    static var isPlay = false
    let dictToSend: [String: String] = ["fileToPlay": "Two_Little_Bums" ]
override func sceneDidLoad() {
    self.physicsWorld.contactDelegate=self
    }
    override func didMove(to view: SKView){
        spawnPlayer()
        addChild(player!)
        counter=GameOver.getScoreBegin()
        time=GameOver.getScore()
        labelScore = SKLabelNode()
        labelScore?.text="Score: "+String(counter)
        labelScore?.position=CGPoint(x: -110, y: 330)
        labelScore?.fontSize=30
        labelScore?.fontColor=SKColor.systemPink
        labelScore?.fontName="Marker Felt Thin"
        addChild(labelScore!)
        if !MainGame.isPlay{
            NotificationCenter.default.post(name: Notification.Name(rawValue: "PlayBackgroundSound"), object: self, userInfo:dictToSend) //posts the notification
            MainGame.isPlay=true
        }
        motionManager.startAccelerometerUpdates()
        startTime()
       }
    func spawnPlayer(){
        player = SKSpriteNode(imageNamed: "player.png")
             player?.name="player"
             player?.size=CGSize(width: 90, height: 140)
             player?.physicsBody=SKPhysicsBody(circleOfRadius: 90/2)
             player?.physicsBody?.affectedByGravity=true
             player?.physicsBody?.isDynamic=true
             player?.position=CGPoint(x: 10,y: -300)
             player?.physicsBody?.categoryBitMask = ColliderType.Player
             player?.physicsBody?.collisionBitMask=ColliderType.Objects
             player?.physicsBody?.contactTestBitMask=ColliderType.Objects
            player?.physicsBody?.fieldBitMask=1
        player?.physicsBody?.mass=10
    }
    
    override func update(_ currentTime: TimeInterval) {
        if let accelerometerData = motionManager.accelerometerData{
            physicsWorld.gravity = CGVector(dx: accelerometerData.acceleration.x * 9.8, dy: accelerometerData.acceleration.y * 9.8)
        }
        counter-=1
         labelScore?.text="Score "+String(counter)
         if(counter<0)
       {   //timeCount.invalidate()
             timeCountForResult.invalidate()
             GameOver.setScoreBegin(time)
             gameOver()
         }
    }

    func startTime(){
        timeCountForResult = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timeForResult), userInfo: nil, repeats: true)
    }
    @objc func timeForResult(){
    
        time+=1
    }
//    @objc func decrementCounter(){
//        counter-=1
//        labelScore?.text="Score "+String(counter)
//        if(counter<0)
//        {   timeCount.invalidate()
//            timeCountForResult.invalidate()
//            GameOver.setScoreBegin(time)
//            gameOver()
//        }
//
//    }
    
    func gameOver(){
        GameOver.setScore(time)
    
        NotificationCenter.default.post(name: Notification.Name(rawValue: "StopBackgroundSound"), object: self)
        MainGame.isPlay=false
        mainGame = GameScene(fileNamed: "GameOver");
        self.view?.presentScene(mainGame, transition: transition)
                       
    }

    func didBegin(_ contact: SKPhysicsContact) {
        
        if (contact.bodyA.node!.name=="player"&&contact.bodyB.categoryBitMask==ColliderType.Objects){
           
            let type = contact.bodyB.node?.name
            
            switch type {
            case "plate":
                contact.bodyB.node?.removeFromParent()
                counter-=100
                labelScore?.text="Score "+String(counter)
                if(counter<=0){
                                       gameOver()
                               }
            case "pills":
                contact.bodyB.node?.removeFromParent()
                counter+=300
                labelScore?.text="Score "+String(counter)
            case "end":
                openNewFloor()
            default:
                break
            }
            
        }
        else if contact.bodyB.node!.name=="player"&&contact.bodyA.categoryBitMask==ColliderType.Objects{
            let type = contact.bodyA.node?.name
        
            switch type {
                case "plate":
                    contact.bodyA.node?.removeFromParent()
                    counter-=100
                    labelScore?.text="Score "+String(counter)
                    if(counter<=0){
                        gameOver()
                }
                    
                case "pills":
                    contact.bodyA.node?.removeFromParent()
                    counter+=300
                    labelScore?.text="Score "+String(counter)
                case "end":
                    openNewFloor()
                default:
                    break
                }
        }
       
    }
    
    func openNewFloor(){
        let numOfFloor = Int.random(in: 1...6)
        GameOver.setScoreBegin(counter)
        GameOver.setScoreTimeForEnd(time)
        switch numOfFloor{
        case 1:
            mainGame = GameScene(fileNamed: "Floor1")
        case 2:
            mainGame = GameScene(fileNamed: "Floor2")
        case 3:
            mainGame = GameScene(fileNamed: "Floor3")
        default:
            mainGame = GameScene(fileNamed: "Floor4")
        }
        mainGame.size=CGSize(width: 750, height: 1334)

         self.view?.presentScene(mainGame, transition: transition)
    }
    
}
