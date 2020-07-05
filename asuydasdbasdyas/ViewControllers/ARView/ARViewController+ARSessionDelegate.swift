//
//  ViewController+ARSessionDelegate.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 28/06/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import Foundation
import ARKit

extension ARViewController: ARSessionDelegate{
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        if let planeAnchor = anchor as? ARPlaneAnchor{
            let plane = Plane(anchor: planeAnchor, in: sceneView)
            node.addChildNode(plane)
        }
        else if anchor.isKind(of: ARAnchor.self){
            print("Added Generic Anchor.")
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        
        // Update only anchors and nodes set up by `renderer(_:didAdd:for:)`.
        
        if !isAreaLargeEnough, let planeAnchor = anchor as? ARPlaneAnchor
        {
            if let plane = node.childNodes.first as? Plane
            {
                updateDebugPlane(planeAnchor, plane)
     
                let planeAnchorArea = planeAnchor.extent.x * planeAnchor.extent.z
                if planeAnchorArea > maxAreaFound {
                    maxAreaFound = planeAnchorArea
                }
                
                DispatchQueue.main.async {
                    self.scanProgressBar.progress = self.maxAreaFound / self.minimumAreaRequired
                }
                
                if  planeAnchorArea >= minimumAreaRequired{
                            
                    isAreaLargeEnough = true
                    
                    let config = ARWorldTrackingConfiguration()
                    sceneView.session.run(config)
                    
                    //print(planeAnchor.transform)
                    
                    setWorldOrigin(planeAnchor.transform)
                    
                    print("Area is large enough.")
                }
            }
        }
    }
    
    
    func updateDebugPlane(_ planeAnchor: ARPlaneAnchor, _ plane: Plane){
        
        if let planeGeometry = plane.meshNode.geometry as? ARSCNPlaneGeometry
        {
              planeGeometry.update(from: planeAnchor.geometry)
        }

      // Update extent visualization to the anchor's new bounding rectangle.
        if let extentGeometry = plane.extentNode.geometry as? SCNPlane{
          extentGeometry.width = CGFloat(planeAnchor.extent.x)
          extentGeometry.height = CGFloat(planeAnchor.extent.z)
          
            if let areaText = plane.areaNode!.geometry as? SCNText{
                areaText.string = String(planeAnchor.extent.x * planeAnchor.extent.z)
            }
            
          plane.extentNode.simdPosition = planeAnchor.center
        }
      
      // Update the plane's classification and the text position
        if #available(iOS 12.0, *),
            let classificationNode = plane.classificationNode,
            let classificationGeometry = classificationNode.geometry as? SCNText {
            let currentClassification = planeAnchor.classification.description
            if let oldClassification = classificationGeometry.string as? String, oldClassification != currentClassification {
                classificationGeometry.string = currentClassification
                classificationNode.centerAlign()
            }
        }
    }
}
