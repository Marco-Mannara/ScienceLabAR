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
    @IBOutlet var promptView: UIView!
    @IBOutlet var scanView: UIView!
    @IBOutlet var scanProgressBar: UIProgressView!
    @IBOutlet var controlsView: UIView!
    
    let coachingOverlay = ARCoachingOverlayView()
    
    let debugPlaneDetection : Bool = true
    
    let minimumAreaRequired : Float = 0.5
    var isAreaLargeEnough : Bool = false
    var maxAreaFound : Float = 0.0
    
    var worldOriginSet : Bool = false
    var worldOriginTransform : simd_float4x4 = simd_float4x4.init(simd_float4.zero, simd_float4.zero, simd_float4.zero, simd_float4.zero)
    
    override public var shouldAutorotate: Bool{
        return true
    }
    
    override public var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
        return .landscapeRight
    }
    
    override public var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return .landscapeRight
    }
    
    
    //MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let value = UIInterfaceOrientation.landscapeRight.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")

        promptView.isHidden = true
        scanView.isHidden = false
        
        GameManager.initialize(sceneView)
        
        setupSessionCoaching()
        
        sceneView.session.delegate = self
        sceneView.debugOptions = [.showWorldOrigin]
        sceneView.allowsCameraControl = false
        sceneView.showsStatistics = true
        sceneView.delegate = self
        sceneView.isMultipleTouchEnabled = true
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal]
        
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        print("memory warning received")
    }
    
    
    //MARK: - Gesture Recognizer Setup
    private func setupGestureRecognizers(){
        /*
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(leftStickPanHandler(_:)))
        sceneView.addGestureRecognizer(panGestureRecognizer)
        */
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTap(_:)))
        sceneView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func viewAdjustPanHandler(_ gesture: UIPanGestureRecognizer){
        switch gesture.state{
        case .began: break
            //GameManager.getInstance().TouchController?.leftStick?.pressed(gesture.location(in: sceneView))
        case .changed: break
            //GameManager.getInstance().TouchController?.leftStick?.updateState(gesture.location(in: sceneView))
        case .ended: break
            //GameManager.getInstance().TouchController?.leftStick?.released()
        default: break
            //GameManager.getInstance().TouchController?.leftStick?.released()
        }
    }
    
    @objc func onTap(_ gesture: UITapGestureRecognizer)
    {
        let position = gesture.location(in: sceneView)
        GameManager.getInstance().inputManager?.onTap(sceneView, position)
    }
    
    //MARK: - UIButtons Callbacks
    
    @IBAction func promptYesTapped(_ sender: Any)
    {
        //print("Yes tapped")
        promptView.isHidden = true
    }
    
    @IBAction func promptNoTapped(_ sender: Any)
    {
        //print("No tapped")
        let alert = UIAlertController(title: "Options", message: "Choose a method for retracking.", preferredStyle: .alert)
    
        alert.addAction(UIAlertAction(title: "Scan Again", style: .default, handler: {(action) -> Void in
            
            self.promptView.isHidden = true
            self.scanProgressBar.isHidden = false
            
            DispatchQueue.main.async {
                //self.sceneView.scene = SCNScene()
                self.sceneView.session.pause()
                GameManager.getInstance().sceneManager?.hideScene()
                
                self.maxAreaFound = 0.0
                self.isAreaLargeEnough = false
                
                let config = ARWorldTrackingConfiguration()
                config.planeDetection = .horizontal
                self.sceneView.session.run(config,options: [.removeExistingAnchors,.resetTracking])
            }
            }))
        alert.addAction(UIAlertAction(title: "Adjust Manually", style: .default, handler: {(action) -> Void in
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))


        self.present(alert, animated: true)
    }
    
    @IBAction func inspectButtonTapped(_ sender: Any) {
    }
    
    @IBAction func resetButtonTapped(_ sender: Any) {
    }
    
    @IBAction func infoButtonTapped(_ sender: Any) {
    }
    
    @IBAction func settingsButtonTapped(_ sender: Any) {
    }
    
    //MARK: - Other functions
    
    @objc
    func projectWorldOrigin(_ point: CGPoint)
    {
        if let transform  = raycastFirstHit(point){
            if !worldOriginSet{
                
                let anchor = ARAnchor(name: "worldOrigin",transform: transform)
                sceneView.session.add(anchor: anchor)
                setWorldOrigin(transform)
                
                //instantiateGameScene("test")
                print("Added World Root.")
            }
        }
        else
        {
            print("Raycast missed.")
        }
    }
    
    func setWorldOrigin(_ transform: simd_float4x4){
        worldOriginTransform = transform
        worldOriginSet = true
        
        let thread = DispatchQueue.init(label: "sceneLoad")
        thread.async {
            GameManager.getInstance().sceneManager!.showScene("experiment", nil)
            let sceneRoot = self.sceneView.scene.rootNode.childNode(withName: "SCENE_ROOT", recursively: false)
            sceneRoot!.simdPosition = transform.getPosition()
        }
        DispatchQueue.main.async {
            self.setupGestureRecognizers()
            self.promptView.isHidden = false
            self.scanView.isHidden = true
        }
//        DispatchQueue.main.async {
//
//            //self.gameManager?.instantiatePlayer(simd_float3(0,1,-2))
//        }
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
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        GameManager.getInstance().updateManager?.update(time)
        if let cameraPosition = sceneView.session.currentFrame?.camera.transform.getPosition(){
            GameManager.getInstance().sceneManager?.arCameraNode?.simdPosition = cameraPosition
        }
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
