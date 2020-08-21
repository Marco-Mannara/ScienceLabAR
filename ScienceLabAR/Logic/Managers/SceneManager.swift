//
//  LevelMaker.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 29/04/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import ARKit
import SceneKit

class SceneManager : NSObject, SCNPhysicsContactDelegate{
    
    
    var currentScene : SCNScene?
    var mainCameraNode : SCNNode?
    var currentExperiment : Experiment?
    
    private var sceneView : SCNView?
    private var sceneLoaded = false
    
    var isSceneHidden : Bool {
        get{
            return currentScene?.rootNode.isHidden ?? false
        }
        set{
            currentScene?.rootNode.isHidden = newValue
            GameManager.getInstance().inputManager?.enabled = !newValue
        }
    }
    
    func loadExperimentScene(_ name: String)
    {
        let scene = SCNScene(named: "art.scnassets/scenes/experiment.scn")!
        let experiment = ExperimentPersistence.loadExperiment(name)!
        
        currentScene = scene
        currentScene?.physicsWorld.contactDelegate = self
        
        currentExperiment = experiment
        currentExperiment?.spawn(in: scene)
        GameManager.getInstance().inputManager?.enabled = true
       
        mainCameraNode = scene.rootNode.childNode(withName: "mainCamera", recursively: true)
        /*
        mainCameraNode = SCNNode()
        mainCameraNode?.name = "arCamera"
        currentScene?.rootNode.addChildNode(mainCameraNode!)*/
        
    }

    func isScreenLeftSideLandscape(_ location: CGPoint) -> Bool{
        return location.x <= sceneView!.bounds.width / 2
    }
    
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
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
