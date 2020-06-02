//
//  GameViewController.swift
//  PigoPenguin_In_The_Dish_Shop
//
//  Created by Sergey Nazarov on 27.01.2020.
//  Copyright © 2020 HSE2020185. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import AVFoundation
class GameViewController: UIViewController {
var bgSoundPlayer:AVAudioPlayer?
    override func viewDidLoad() {
            super.viewDidLoad()
            
            if let view = self.view as! SKView? {
            
                if let scene = SKScene(fileNamed: "GameScene") {
                
                    scene.scaleMode = .aspectFill
                    
                   
                    view.presentScene(scene)
                }
                
                view.ignoresSiblingOrder = true
                
                view.showsFPS = true
                view.showsNodeCount = true
            }
        NotificationCenter.default.addObserver(self, selector: #selector(GameViewController.playBackgroundSound(_:)), name: NSNotification.Name(rawValue: "PlayBackgroundSound"), object: nil)
               
               
               NotificationCenter.default.addObserver(self, selector: #selector(GameViewController.stopBackgroundSound), name: NSNotification.Name(rawValue: "StopBackgroundSound"), object: nil)
        }
    @objc func playBackgroundSound(_ notification: Notification) {
    
        let name = (notification as NSNotification).userInfo!["fileToPlay"] as! String

    
        if (bgSoundPlayer != nil){
            
            bgSoundPlayer!.stop()
            bgSoundPlayer = nil
            
            
        }
            if (name != ""){
            
            let fileURL:URL = Bundle.main.url(forResource:name, withExtension: "mp3")!
            
            do {
                bgSoundPlayer = try AVAudioPlayer(contentsOf: fileURL)
            } catch _{
                bgSoundPlayer = nil
                
            }
            
            bgSoundPlayer!.volume = 0.75
            bgSoundPlayer!.numberOfLoops = -1
            bgSoundPlayer!.prepareToPlay()
            bgSoundPlayer!.play()
            
        }
        
        
    }
    
    
    
    @objc func stopBackgroundSound() {
        
        if (bgSoundPlayer != nil){
            
            bgSoundPlayer!.stop()
            bgSoundPlayer = nil
            
            
        }
        
    }
        override var shouldAutorotate: Bool {
            return true
        }

        override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
            if UIDevice.current.userInterfaceIdiom == .phone {
                return .allButUpsideDown
            } else {
                return .all
            }
        }

        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
        }

        override var prefersStatusBarHidden: Bool {
            return true
        }
    }
