

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    var transition:SKTransition = SKTransition.fade(withDuration: 1)
    var mainGame:SKScene!
    private var lastUpdateTime : TimeInterval = 0
    private var label : SKLabelNode?
    var background: SKSpriteNode?
    var newGame:SKSpriteNode?
    var backgroundMusic: SKAudioNode!
    override func sceneDidLoad() {

        self.lastUpdateTime = 0
        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        if let label = self.label {
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }
        label?.zPosition=1
        self.background=self.childNode(withName: "//background") as? SKSpriteNode
        self.newGame=self.childNode(withName: "newGame") as? SKSpriteNode
        newGame?.zPosition=1
        if let musicURL = Bundle.main.url(forResource: "A_Quiet_Thought", withExtension: "mp3") {
            backgroundMusic = SKAudioNode(url: musicURL)
            addChild(backgroundMusic)
        }
        GameOver.setScoreBegin(1944)
        GameOver.setScoreTimeForEnd(0)
    }
    
    
   
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
             let location = touch.location(in: self)
             let touchedNode = atPoint(location)
             if touchedNode.name == "newGame" {
                mainGame = GameScene(fileNamed: "Floor1");
                mainGame.size=self.size; self.view?.presentScene(mainGame, transition: transition)
             }
        }
    
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        let dt = currentTime - self.lastUpdateTime
        
        for entity in self.entities {
            entity.update(deltaTime: dt)
        }
        
        self.lastUpdateTime = currentTime
    }
}
