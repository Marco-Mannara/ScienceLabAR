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
    
    private static var instance : GameManager?
    
    var playerEntity : Player?
    var updateManager : UpdateManager?
    var sceneManager : SceneManager?
    var TouchController : Controller?
    var arScene : ARSCNView?
    
    var arCameraTransform : simd_float4x4?{
        return arScene?.session.currentFrame?.camera.transform ?? sceneManager?.currentGameLevel?.camera.simdTransform
    }
    
    private init(){
        updateManager = UpdateManager()
    }
    
    static func getInstance() -> GameManager{
        if GameManager.instance == nil{
            GameManager.instance = GameManager()
        }
        return GameManager.instance!
    }
    
    static func initialize(_ sceneView : SCNView){
        let instance = getInstance()
        instance.sceneManager = SceneManager(sceneView)
        
        /*
        if let path = Bundle.main.path(forResource: "NodeTechnique", ofType: "plist") {
                  if let dict = NSDictionary(contentsOfFile: path)  {
                      let dict2 = dict as! [String : AnyObject]
                      let technique = SCNTechnique(dictionary:dict2)

                      // set the glow color to yellow
                      let color = SCNVector3(0.0, 1.0, 1.0)
                      technique?.setValue(NSValue(scnVector3: color), forKeyPath: "glowColorSymbol")

                      sceneView.technique = technique
              }
          }*/
    }
    
    static func initialize(_ arSceneView : ARSCNView){
        let instance = getInstance()
        instance.sceneManager = SceneManager(arSceneView)
        
        if let path = Bundle.main.path(forResource: "NodeTechnique", ofType: "plist") {
                  if let dict = NSDictionary(contentsOfFile: path)  {
                      let dict2 = dict as! [String : AnyObject]
                      let technique = SCNTechnique(dictionary:dict2)

                      // set the glow color to yellow
                      let color = SCNVector3(0.0, 1.0, 1.0)
                      technique?.setValue(NSValue(scnVector3: color), forKeyPath: "glowColorSymbol")

                      arSceneView.technique = technique
                  }
              }
    }
    
    func instantiatePlayer(){
        guard let gameLevel = sceneManager?.currentGameLevel else {
            print("There's no level loaded. Aborting player spawn")
            return
        }
        
        let spawnPoint = gameLevel.spawnPoint
        instantiatePlayer(spawnPoint)
    }
    
    func instantiatePlayer(_ position: simd_float3, _ rotation: simd_float3 = simd_float3.zero)
    {
        playerEntity = Player(100)
        playerEntity!.spawn(sceneManager!.currentScene!, position)
        sceneManager!.touchController!.jumpButton!.action = {() -> Void in
            self.playerEntity!.movement!.jump()
        }
        updateManager!.subscribe(playerEntity!)
    }
        
    func destroyPlayer(){
        
    }
}
