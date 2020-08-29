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
    
    @IBOutlet var progressIndicator: UILabel!
    
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
        GameManager.getInstance().viewController = self
        
        let experimentSpawn = DispatchQueue(label: "experimentSpawn")
        experimentSpawn.async {
            self.sceneView.scene = GameManager.getInstance().sceneManager.currentScene
        }
    }    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        GameManager.getInstance().sceneManager.currentExperiment?.goals?.updateExperimentProgression()
        performSegue(withIdentifier: "explanation", sender: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch in touches {
            let position = touch.location(in: sceneView)
            
            GameManager.getInstance().inputManager?.onTap(sceneView, position)
        }
    }
    
    func isScreenLeftSideLandscape(_ location: CGPoint) -> Bool{
        return location.x <= sceneView.bounds.width / 2
    }
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        GameManager.getInstance().updateManager?.update(time)
    }
    
    @IBAction func inspectButtonPressed(_ sender: UIButton) {
        DispatchQueue.main.async {
            GameManager.getInstance().sceneManager.currentExperiment!.selection!.selectedTool?.state!.enter(StateInspect.self)
        }
    }
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        
    }
    @IBAction func infoButtonPressed(_ sender: UIButton) {
        //performSegue(withIdentifier: "explanation", sender: nil)
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
