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


class ARViewController: UIViewController {

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
    
    let sceneHandlerQueue = DispatchQueue.init(label: "sceneHandler")
    
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
        
        
        setupSessionCoaching()

        sceneView.session.delegate = self
        sceneView.debugOptions = [.showWorldOrigin]
        sceneView.allowsCameraControl = false
        sceneView.showsStatistics = true
        sceneView.delegate = self
        sceneView.isMultipleTouchEnabled = true
        
        sceneHandlerQueue.async {
            self.sceneView.scene = GameManager.getInstance().sceneManager.currentScene!
            GameManager.getInstance().sceneManager.isSceneHidden = true
            print("EXPERIMENT LOADED")
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal]
        
        self.navigationController?.navigationBar.isHidden = true
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        print("memory warning received")
    }
    
    
    //MARK: - Gesture Recognizer Setup
    private func setupGestureRecognizers(){
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
                //GameManager.getInstance().sceneManager?.hideScene()
                
                self.maxAreaFound = 0.0
                self.isAreaLargeEnough = false
                
                let config = ARWorldTrackingConfiguration()
                config.planeDetection = .horizontal
                self.sceneView.session.run(config,options: [.removeExistingAnchors,.resetTracking])
            }
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
    
    func setWorldOrigin(_ transform: simd_float4x4){
        worldOriginTransform = transform
        worldOriginSet = true
        
        sceneHandlerQueue.async {
            GameManager.getInstance().sceneManager.currentExperiment!.sceneRoot!.simdPosition = transform.getPosition()
            GameManager.getInstance().sceneManager.isSceneHidden = false
        }
        
        DispatchQueue.main.async {
            self.setupGestureRecognizers()
            self.promptView.isHidden = false
            self.scanView.isHidden = true
        }
    }
    
    func raycastFirstHit(_ point: CGPoint) -> simd_float4x4? {
        let query = sceneView.raycastQuery(from: point, allowing: .estimatedPlane, alignment: .horizontal)
        let results = sceneView.session.raycast(query!)
        
        return results.first?.worldTransform
    }
}
