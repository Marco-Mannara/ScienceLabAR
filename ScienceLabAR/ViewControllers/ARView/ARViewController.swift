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

    @IBOutlet var progressIndicator: UILabel!
    @IBOutlet var sceneView: ARSCNView!
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

        scanView.isHidden = false
        
        setupSessionCoaching()

        sceneView.session.delegate = self
        sceneView.allowsCameraControl = false
        sceneView.delegate = self
        sceneView.isMultipleTouchEnabled = true
        GameManager.getInstance().viewController = self
        
        sceneHandlerQueue.async {
            self.sceneView.scene = GameManager.getInstance().sceneManager.currentScene!
            GameManager.getInstance().sceneManager.isSceneHidden = true
            print("EXPERIMENT LOADED")
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal]
        sceneView.session.run(configuration)
        
        self.navigationController?.navigationBar.isHidden = true
        
        GameManager.getInstance().sceneManager.currentExperiment?.goals?.updateExperimentProgression()
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
    
    
    @objc func onTap(_ gesture: UITapGestureRecognizer)
    {
        let position = gesture.location(in: sceneView)
        GameManager.getInstance().inputManager?.onTap(sceneView, position)
    }
    
    //MARK: - UIButtons Callbacks
    
    @IBAction func inspectButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func infoButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "explanation", sender: nil)
    }
    
    func retrack(){
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        sceneView.session.run(configuration, options: [.resetTracking,.removeExistingAnchors])
        
        GameManager.getInstance().sceneManager.isSceneHidden = true
        isAreaLargeEnough = false
        worldOriginSet = false
        
        coachingOverlay.goal = .horizontalPlane
        coachingOverlay.setActive(true, animated: true)
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
            //self.promptView.isHidden = false
            self.scanView.isHidden = true
            self.coachingOverlay.setActive(false, animated: true)
        }
    }
    
    func raycastFirstHit(_ point: CGPoint) -> simd_float4x4? {
        let query = sceneView.raycastQuery(from: point, allowing: .estimatedPlane, alignment: .horizontal)
        let results = sceneView.session.raycast(query!)
        
        return results.first?.worldTransform
    }
}
