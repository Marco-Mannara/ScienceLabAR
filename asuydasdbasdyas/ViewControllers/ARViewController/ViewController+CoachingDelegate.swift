//
//  File.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 27/06/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import Foundation
import ARKit
import SceneKit


extension ViewController : ARCoachingOverlayViewDelegate{
    
    func setupSessionCoaching(){
        coachingOverlay.session = sceneView.session
        coachingOverlay.delegate = self
        
        coachingOverlay.translatesAutoresizingMaskIntoConstraints = false
        sceneView.addSubview(coachingOverlay)
        
        NSLayoutConstraint.activate([
            coachingOverlay.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            coachingOverlay.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            coachingOverlay.widthAnchor.constraint(equalTo: view.widthAnchor),
            coachingOverlay.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        coachingOverlay.activatesAutomatically = true
        coachingOverlay.goal = .horizontalPlane
    }
    
    func coachingOverlayViewWillActivate(_ coachingOverlayView: ARCoachingOverlayView) {
        
    }
    
    func coachingOverlayViewDidDeactivate(_ coachingOverlayView: ARCoachingOverlayView) {
        
    }
    

}
