//
//  MenuSceneClass.swift
//  PigoPenguin_In_The_Dish_Shop
//
//  Created by Sergey Nazarov on 27.01.2020.
//  Copyright © 2020 HSE2020185. All rights reserved.
//
import SpriteKit
import GameplayKit
import UIKit

class MainMenu: SKScene {

/* UI Connections */
var buttonPlay: MSButtonNode!
    var titleLabel: SKLabelNode?
    var newGameLabel: SKLabelNode?
   
    override func didMove(to view: SKView) {
        self.titleLabel=SKLabelNode(fontNamed: "Chalkduster")
        self.newGameLabel = SKLabelNode(fontNamed: "Chalkduster")
        
        self.titleLabel!.fontSize=32
        self.newGameLabel!.fontSize=19
        
        self.titleLabel!.fontColor=UIColor.magenta
        self.newGameLabel!.fontColor=UIColor.magenta
        
        self.titleLabel!.text="PigoPenguin In The Dish Shop"
        self.newGameLabel!.text="New Game"
        
        self.titleLabel!.name="title"
        self.newGameLabel?.name="new"
        
        self.titleLabel!.position = CGPoint(x:
            self.frame.midX, y:self.scene!.frame.midY )
        self.newGameLabel!.position = CGPoint(x: self.scene!.frame.midX, y:self.scene!.frame.midY  - titleLabel!.frame.height)
        
        self.addChild(self.titleLabel!)
        self.addChild(self.newGameLabel!)
        
    }
    func loadGame() {
     
              
        /* 1) Grab reference to our SpriteKit view */
       /* guard let skView = self.view as SKView? else {
            print("Could not get Skview")
            return
        }*/

        /* 2) Load Game scene */
        guard let scene = GameScene(fileNamed:"GameScene") else {
            print("Could not make GameScene, check the name is spelled correctly")
            return
        }
          let skView = view as! SKView
        skView.presentScene(scene)
        /* 3) Ensure correct aspect mode */
        scene.scaleMode = .aspectFill

        /* Show debug */
        skView.showsPhysics = true
        skView.showsDrawCount = true
        skView.showsFPS = true

        /* 4) Start game scene */
        skView.presentScene(scene)
    }
   /* override func touchesBegan( touches: NSSet, withEvent event: UIEvent?) {
        self.menuHelper(touches)
    }
    func menuHelper(touches: NSSet){
        for touch in touches{
            let nodeAtTouch = self.nodeAtPoint(touch.locationInNode(self))
            if nodeAtTouch.name
        }
    }*/
}
