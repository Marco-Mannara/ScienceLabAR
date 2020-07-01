//
//  LevelMaker.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 29/04/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import ARKit
import SceneKit
import SpriteKit

class SceneManager : NSObject, SCNPhysicsContactDelegate{

    var touchController : Controller?
    
    var sceneView : SCNView
    var currentScene : SCNScene?
    var currentOverlayScene : SKScene?
    
    private var loadedSceneName : String = ""
    private var loadedOverlayName : String?
    
    var currentExperiment : Experiment?
    
    var arCameraNode : SCNNode?

    
    
    init(_ sceneView : SCNView){
        self.sceneView = sceneView
    }
    
    
    func showScene(_ named: String, _ withOverlayNamed : String?)
    {
        if withOverlayNamed != loadedOverlayName{
            if let overlayName = withOverlayNamed{
                      let overlayScene = SKScene(fileNamed: overlayName + ".sks")!
                      currentOverlayScene = overlayScene
                      overlayScene.isUserInteractionEnabled = false
                      overlayScene.size = CGSize(width: sceneView.bounds.width, height: sceneView.bounds.height)
                      sceneView.overlaySKScene = overlayScene
            }
        }
        else{
            
        }

        if loadedSceneName != named{
            let scene = SCNScene(named: "art.scnassets/scenes/" + named + ".scn")
            loadedSceneName = named
            loadedOverlayName = withOverlayNamed
            
            sceneView.scene = scene!
            sceneView.scene!.physicsWorld.contactDelegate = self
            
            currentScene = scene
            //touchController = Controller(currentOverlayScene)
            //currentGameLevel = GameLevel(scene!)
            
            if let _ = sceneView as? ARSCNView {
                arCameraNode = SCNNode()
                arCameraNode?.name = "arCamera"
                currentScene?.rootNode.addChildNode(arCameraNode!)
            }
        }
        else{
            currentScene?.rootNode.isHidden = false
        }
    }
    
    func loadExperiment(_ name: String){
        if let scene = currentScene{
            currentExperiment = Experiment(scene, name)
            GameManager.getInstance().inputManager?.enabled = true
        }
        else{
            print("Couldn't load experiment as there's no scene loaded")
        }
    }
    
    func hideScene(){
        currentScene?.rootNode.isHidden = true
        GameManager.getInstance().inputManager?.enabled = false
    }
    
    
    /*
    private func setupGameControlsRecognizers(){
         let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(leftStickPanHandler(_:)))
         sceneView.addGestureRecognizer(panGestureRecognizer)
         
         let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(rightButtonsTapHandler(_:)))
         sceneView.addGestureRecognizer(tapGestureRecognizer)
     }*/
     

    
    func isScreenLeftSideLandscape(_ location: CGPoint) -> Bool{
        return location.x <= sceneView.bounds.width / 2
    }
    
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        //print("began contact.")
        if let delegate = contact.nodeB.entity as? EntityCollisionProtocol{
            delegate.collisionBegin(contact, contact.nodeA)
        }
    }
    
    func physicsWorld(_ world: SCNPhysicsWorld, didUpdate contact: SCNPhysicsContact)
    {
        if let delegate = contact.nodeB.entity as? EntityCollisionProtocol{
            //delegate.collisionUpdate(contact, contact.nodeA)
        }
    }
    
    func physicsWorld(_ world: SCNPhysicsWorld, didEnd contact: SCNPhysicsContact) {
        if let delegate = contact.nodeB.entity as? EntityCollisionProtocol{
            delegate.collisionEnd(contact, contact.nodeA)
        }
    }
}
