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
        
        
        
        //GameManager.getInstance().instantiatePlayer()
        /*
        let request : NSFetchRequest<PlayerData+> = PlayerData+.fetchRequest()
        do{
            let result = try GamePersistenceManager.context.fetch(request)
            
            for save in result{
                print(save.name ?? "No name")
                print(save.dateOfCreation ?? "No Date")
            }
            
        }catch{
        }
    
        
        let testSave = PlayerData(context: GamePersistenceManager.persistentContainer.viewContext)
        
        testSave.dateOfCreation = Date()
        testSave.name = "Cr4zyRi0s"
        
        GamePersistenceManager.saveContext()*/
        
        /*
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(5000)) {
            let node = SCNNode(geometry: SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0))
            node.position = SCNVector3(0,0.2,0)
            GameManager.getInstance().sceneManager?.currentScene?.rootNode.addChildNode(node)
            let actionTester = ActionTest(node)
            actionTester.executeAction()
        }*/
    }    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch in touches {
            let position = touch.location(in: sceneView)
            let firstResult = sceneView.hitTest(position, options: nil).first
            
            
            if let hitTool = firstResult?.node.entity as? Tool{
                GameManager.getInstance().sceneManager?.currentExperiment?.selectTool(hitTool)
            }
            else{
            }
            
            /*
            let gameManagerInstance = GameManager.getInstance()
            
            if isScreenLeftSideLandscape(position){
                gameManagerInstance.sceneManager?.touchController?.leftStick?.pressed(position)
            }
            else
            {
                gameManagerInstance.sceneManager?.touchController?.checkButtonHit(position)
            }*/
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        /*
        for touch in touches{
            
            let location = touch.location(in: sceneView)
            if isScreenLeftSideLandscape(location){
                GameManager.getInstance().sceneManager?.touchController?.leftStick?.updateState(location)
            }
        }*/
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
      /*
      for touch in touches{
            let location = touch.location(in: sceneView)
            if isScreenLeftSideLandscape(location){
                GameManager.getInstance().sceneManager?.touchController?.leftStick?.released()
            }
        }*/
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
