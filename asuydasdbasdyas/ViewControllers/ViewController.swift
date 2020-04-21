//
//  ViewController.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 12/04/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import GameplayKit


class ViewController: UIViewController {

    @IBOutlet var sceneView: ARSCNView!
    
    let sceneName : String = "test"
    let loadSceneWithName : Bool = false
    let debugPlaneDetection : Bool = true
    let minimumAreaRequired : Float = 0.5
    
    var isAreaLargeEnough : Bool = false
    var worldOriginSet : Bool = false
    
    var tapAction : (CGPoint) -> () = { (position) -> Void in
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        sceneView.session.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        sceneView.debugOptions = [.showWorldOrigin]
        
        sceneView.scene = SCNScene()
        
        tapAction = setWorldOrigin(_:)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal,.vertical]
        
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        if let point = touches.first?.location(in: sceneView){
            tapAction(point)
        }
    }
    
    @objc
    func setWorldOrigin(_ point: CGPoint)
    {
        if let transform  = raycastFirstHit(point){
            if !worldOriginSet{
                
                let anchor = ARAnchor(name: "worldOrigin",transform: transform)
                sceneView.session.add(anchor: anchor)
                sceneView.session.setWorldOrigin(relativeTransform: transform)
                worldOriginSet = true
                
                instantiateGameScene("test")
                
                tapAction = createCube(_:)
                print("Added World Root.")
                
                
            }
        }
        else
        {
            print("Raycast missed.")
        }
    }
    
    func instantiateGameScene(_ name: String)
    {
        if let scene = SCNScene(named: "art.scnassets/" + name + ".scn"){
            sceneView.scene = scene
        }
    }
    
    
    func createCube(_ point: CGPoint){
        
        if let transform = raycastFirstHit(point){
            let box = SCNBox(width: 0.05,height: 0.05,length: 0.05,chamferRadius: 0)
            let node = SCNNode(geometry: box)
            node.simdPosition =  transform.getPosition() + simd_float3(0.0, 0.025, 0.0)
            sceneView.scene.rootNode.addChildNode(node)
        }
        else{
            print("Raycast missed.")
        }
    }
    
    
    func raycastFirstHit(_ point: CGPoint) -> simd_float4x4? {
        let query = sceneView.raycastQuery(from: point, allowing: .estimatedPlane, alignment: .horizontal)
        let results = sceneView.session.raycast(query!)
        
        return results.first?.worldTransform
    }
}

// MARK: - ARSCNViewDelegate

extension ViewController:ARSCNViewDelegate
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
    
    /*
        // Override to create and configure nodes for anchors added to the view's session.
        func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
            let node = SCNNode()
         
            return node
        }
    */

}

// MARK: - ARSessionDelegate
extension ViewController: ARSessionDelegate{
    
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
                
                //print(planeAnchorArea)
                /*
                if  planeAnchorArea >= minimumAreaRequired{
                    
                    
                    isAreaLargeEnough = true
                    
                    let config = ARWorldTrackingConfiguration()
                    config.planeDetection = []
                    sceneView.session.run(config)
                    
                    print("Area is large enough.")
                }*/
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
