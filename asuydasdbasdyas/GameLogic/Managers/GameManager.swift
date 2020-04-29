//
//  GameManager.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 25/04/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import ARKit
import SceneKit
import SpriteKit

class GameManager {
    
    static var SceneCamera : SCNNode?
    static var TouchController : Controller?
    
    static var arScene : ARSCNView?
    
    var playerEntity : Player?
    
    static var updateManager : UpdateManager?
    static var sceneManager : SceneManager?
    
    
    static var arCameraTransform : simd_float4x4?{
        return arScene?.session.currentFrame?.camera.transform ?? GameManager.SceneCamera?.simdTransform
    }
    
    init(_ sceneView : SCNView)
    {
        GameManager.updateManager = UpdateManager()
        GameManager.sceneManager = SceneManager(sceneView)
    }
    
    init(_ arSceneView : ARSCNView)
    {
        GameManager.updateManager = UpdateManager()
        GameManager.sceneManager = SceneManager(arSceneView)
    }
    
    func instantiatePlayer(){
        if let spawnPoint = GameManager.sceneManager?.currentGameLevel?.spawnPoint{
            instantiatePlayer(spawnPoint)
        }
        else{
            print("Couldn't find level player spawn point. Spawning at (0,0,0).")
        }
    }
    
    func instantiatePlayer(_ position: simd_float3, _ rotation: simd_float3 = simd_float3.zero)
    {
        playerEntity = Player(100,5)
        playerEntity!.spawn(GameManager.sceneManager!.currentScene!, position)
        GameManager.updateManager!.subscribe(playerEntity!)
    }
        
    func destroyPlayer(){
        
    }
}
