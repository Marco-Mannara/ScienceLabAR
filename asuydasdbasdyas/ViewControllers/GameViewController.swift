//
//  GameViewController.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 17/04/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import UIKit
import SceneKit
import GameplayKit

class GameViewController: UIViewController, SCNPhysicsContactDelegate, SCNSceneRendererDelegate {

    @IBOutlet var sceneView: SCNView!
    
    static var LeftStick : ControllerStick?
    static var SceneCamera : SCNNode?
    
    var lastUpdate : Double = 0.0
    var deltaTime : Double = 0.0
    
    var isFirstUpdate : Bool = true
    
    var tapAction : (CGPoint) -> () = { (position) -> Void in
    }
    var playerEntity : Player?
    
    override public var shouldAutorotate: Bool{
        return true
    }
    
    override public var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
        return .landscapeLeft
    }
    
    override public var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return .landscapeLeft
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
          let value = UIInterfaceOrientation.landscapeLeft.rawValue
         UIDevice.current.setValue(value, forKey: "orientation")
        
        sceneView.allowsCameraControl = false
        sceneView.showsStatistics = true
        
        sceneView.scene = SCNScene(named: "art.scnassets/test.scn")
        sceneView.scene!.physicsWorld.contactDelegate = self
        GameViewController.SceneCamera = sceneView.scene!.rootNode.childNode(withName: "camera", recursively: false)
        
        sceneView.delegate = self
        
        playerEntity = Player(100, 5)
        playerEntity!.mainNode.position = SCNVector3(0, 0.3, 0)
        
        
        sceneView.scene?.rootNode.addChildNode(playerEntity!.mainNode)
    
        
        GameViewController.LeftStick = ControllerStick()
    }
  
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch in touches {
            let position = touch.location(in: sceneView)
            if isScreenLeftSideLandscape(position){
                GameViewController.LeftStick?.pressed(position)
            }
            else{
                playerEntity?.movement!.jump()
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches{
            let location = touch.location(in: sceneView)
            if isScreenLeftSideLandscape(location){
                GameViewController.LeftStick?.updateState(location)
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
      for touch in touches{
            let location = touch.location(in: sceneView)
            if isScreenLeftSideLandscape(location){
                GameViewController.LeftStick?.released()
            }
        }
    }
    
    
    func isScreenLeftSideLandscape(_ location: CGPoint) -> Bool{
        return location.x <= UIScreen.main.bounds.width / 2
    }
    
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        if isFirstUpdate {
            
            lastUpdate = time
            isFirstUpdate = false
            return
        }
        
        deltaTime = time - lastUpdate
        lastUpdate = time
        if let player = playerEntity{
            player.update(deltaTime: deltaTime)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
