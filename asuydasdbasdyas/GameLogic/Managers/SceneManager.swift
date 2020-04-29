//
//  LevelMaker.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 29/04/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//


import SceneKit
import SpriteKit

class SceneManager : NSObject, SCNPhysicsContactDelegate{

    var touchController : Controller?
    
    var sceneView : SCNView
    var currentScene : SCNScene?
    var currentOverlayScene : SKScene?
    var currentGameLevel : GameLevel?
    
    init(_ sceneView : SCNView){
        self.sceneView = sceneView
    }
    
    
    func loadScene(_ named: String, _ withOverlayNamed : String?)
    {
        if let overlayName = withOverlayNamed{
            let overlayScene = SKScene(fileNamed: overlayName + ".sks")!
            currentOverlayScene = overlayScene
            overlayScene.isUserInteractionEnabled = false
            overlayScene.size = CGSize(width: sceneView.bounds.width, height: sceneView.bounds.height)
            sceneView.overlaySKScene = overlayScene
        }
       
        let scene = SCNScene(named: "art.scnassets/"+named+".scn")
        
        sceneView.scene = scene!
        sceneView.scene!.physicsWorld.contactDelegate = self
        
        currentScene = scene
        touchController = Controller(currentOverlayScene)
        currentGameLevel = GameLevel(scene!)
    }
    
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        
    }
    
    func physicsWorld(_ world: SCNPhysicsWorld, didUpdate contact: SCNPhysicsContact) {
    
    }
    
    func physicsWorld(_ world: SCNPhysicsWorld, didEnd contact: SCNPhysicsContact) {
        
    }
}
