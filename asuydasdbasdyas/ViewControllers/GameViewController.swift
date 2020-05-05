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
        
        sceneView.allowsCameraControl = false
        sceneView.showsStatistics = true
        sceneView.delegate = self
        sceneView.debugOptions = .showPhysicsShapes
        
        GameManager.initialize(sceneView)
        GameManager.getInstance().sceneManager?.loadScene("first_level", "HUD")
        GameManager.getInstance().instantiatePlayer()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch in touches {
            let position = touch.location(in: sceneView)
            let gameManagerInstance = GameManager.getInstance()
            
            if isScreenLeftSideLandscape(position){
                gameManagerInstance.sceneManager?.touchController?.leftStick?.pressed(position)
            }
            else
            {
                gameManagerInstance.sceneManager?.touchController?.checkButtonHit(position)
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches{
            let location = touch.location(in: sceneView)
            if isScreenLeftSideLandscape(location){
                GameManager.getInstance().sceneManager?.touchController?.leftStick?.updateState(location)
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
      for touch in touches{
            let location = touch.location(in: sceneView)
            if isScreenLeftSideLandscape(location){
                GameManager.getInstance().sceneManager?.touchController?.leftStick?.released()
            }
        }
    }
    
    func isScreenLeftSideLandscape(_ location: CGPoint) -> Bool{
        return location.x <= sceneView.bounds.width / 2
    }
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        GameManager.getInstance().updateManager?.update(time)
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
