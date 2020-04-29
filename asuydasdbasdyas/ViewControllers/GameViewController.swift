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

class GameViewController: UIViewController, SCNSceneRendererDelegate {

    @IBOutlet var sceneView: SCNView!
    
    static var LeftStick : ControllerStick?
    static var JumpButton : ControllerButton?
    static var AttackButton : ControllerButton?
    
    var buttons : [ControllerButton?] = []
    
    static var SceneCamera : SCNNode?
    
    var scene : SCNScene?
    var overlayScene : SKScene?
    
    var lastUpdate : Double = 0.0
    var deltaTime : Double = 0.0
    
    var isFirstUpdate : Bool = true
    
    var playerEntity : Player?
    var enemyEntity : Enemy?
    
    var gameManager : GameManager?
    var updateManager : UpdateManager?
    
    override public var shouldAutorotate: Bool{
        return true
    }
    
    override public var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
        return .landscapeRight
    }
    
    override public var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return .landscapeRight
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let value = UIInterfaceOrientation.landscapeRight.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        
        sceneView.allowsCameraControl = true
        sceneView.showsStatistics = true
        sceneView.delegate = self
        sceneView.debugOptions = .showPhysicsShapes
        
        gameManager = GameManager(sceneView)
        GameManager.sceneManager?.loadScene("first_level", "HUD")
        gameManager!.instantiatePlayer()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch in touches {
            let position = touch.location(in: sceneView)
            if isScreenLeftSideLandscape(position){
                GameManager.sceneManager?.touchController?.leftStick?.pressed(position)
            }
            else
            {
                playerEntity?.movement!.jump()
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches{
            let location = touch.location(in: sceneView)
            if isScreenLeftSideLandscape(location){
                GameManager.sceneManager?.touchController?.leftStick?.updateState(location)
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
      for touch in touches{
            let location = touch.location(in: sceneView)
            if isScreenLeftSideLandscape(location){
                GameManager.sceneManager?.touchController?.leftStick?.released()
            }
        }
    }
    
    func isScreenLeftSideLandscape(_ location: CGPoint) -> Bool{
        return location.x <= UIScreen.main.bounds.width / 2
    }
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        GameManager.updateManager?.update(time)
        //print(gameManager?.playerEntity?.mainNode.presentation.simdPosition ?? "")
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
