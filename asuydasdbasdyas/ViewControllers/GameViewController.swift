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
import CoreData

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
        //sceneView.debugOptions = .showPhysicsShapes
        
        GameManager.initialize(sceneView)
        GameManager.getInstance().sceneManager?.showScene("experiment", nil)
        GameManager.getInstance().sceneManager?.loadExperiment("saggioAllaFiamma")
    }    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch in touches {
            let position = touch.location(in: sceneView)
            
            GameManager.getInstance().inputManager?.onTap(sceneView, position)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?){
    }
    
    func isScreenLeftSideLandscape(_ location: CGPoint) -> Bool{
        return location.x <= sceneView.bounds.width / 2
    }
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        GameManager.getInstance().updateManager?.update(time)
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
