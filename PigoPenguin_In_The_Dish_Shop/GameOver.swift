//
//  GameOver.swift
//  PigoPenguin_In_The_Dish_Shop
//
//  Created by Назарова on 28.05.2020.
//  Copyright © 2020 HSE2020185. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit
class GameOver:SKScene {
    
    var labelMyScore: SKLabelNode?
    var labelBestScore:SKLabelNode?
    var returnButton: SKNode?
    var transition:SKTransition = SKTransition.fade(withDuration: 1)
    var backgroundMusic: SKAudioNode!

    var mainGame:SKScene!
    class func setScoreBegin(_ value:Int){
        UserDefaults.standard.set(value, forKey: "kScoreCount")
        UserDefaults.standard.synchronize()
    }
    class func getScoreBegin()->Int{
          return UserDefaults.standard.integer(forKey: "kScoreCount")
    }
   class func setScore(_ value:Int){
        if(value>getScoreBest()){
            setScoreBest(value)
        }
        
        UserDefaults.standard.set(value, forKey: "kScore")
        UserDefaults.standard.synchronize()
    }
    class func setScoreTimeForEnd(_ value:Int){
    
        UserDefaults.standard.set(value, forKey: "kScore")
        UserDefaults.standard.synchronize()
    }
   class func getScore() -> Int {
        return UserDefaults.standard.integer(forKey: "kScore")
    }
    
    
   class func setScoreBest(_ value:Int){
       
        UserDefaults.standard.set(value, forKey: "kScoreBest")
        UserDefaults.standard.synchronize()
    }
    
   class func getScoreBest() -> Int {
        return UserDefaults.standard.integer(forKey: "kScoreBest")
    }
    
     override func sceneDidLoad() {
        self.labelMyScore=self.childNode(withName: "//labelTimeNow") as? SKLabelNode
        labelMyScore?.zPosition=1
        labelMyScore?.text!+=String(GameOver.getScore())
        GameOver.setScore(GameOver.getScore())
        self.labelBestScore=self.childNode(withName:"//labelTimeRecord") as? SKLabelNode
        labelBestScore?.zPosition=1
        labelBestScore?.text!+=String(GameOver.getScoreBest())
        self.returnButton=self.childNode(withName: "//imageReturn")
        returnButton?.zPosition=1
        if let musicURL = Bundle.main.url(forResource: "Alien_Beam", withExtension: "mp3") {
                   backgroundMusic = SKAudioNode(url: musicURL)
                   addChild(backgroundMusic)
               }
    
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
           for touch in touches {
                let location = touch.location(in: self)
                let touchedNode = atPoint(location)
                if touchedNode.name == "imageReturn" {
                   mainGame = GameScene(fileNamed: "GameScene");
                   mainGame.size=CGSize(width: 750, height: 1334)
                    self.view?.presentScene(mainGame, transition: transition)
                }
           }
       }
}
