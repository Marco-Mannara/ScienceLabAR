//
//  ViewController+ARSceneDelegate.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 28/06/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import Foundation
import ARKit


extension ARViewController:ARSCNViewDelegate
{
       func session(_ session: ARSession, didFailWithError error: Error)
       {
           // Present an error message to the user
               
       }
       
       func sessionWasInterrupted(_ session: ARSession) {
           // Inform the user that the session has been interrupted, for example, by presenting an overlay
           
       }
       
       func sessionInterruptionEnded(_ session: ARSession) {
           // Reset tracking and/or remove existing anchors if consistent tracking is required
           
       }
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        GameManager.getInstance().updateManager?.update(time)
        if let cameraPosition = sceneView.session.currentFrame?.camera.transform.getPosition(){
            GameManager.getInstance().sceneManager?.mainCameraNode?.simdPosition = cameraPosition
        }
    }
}
