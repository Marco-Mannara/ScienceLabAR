//
//  SelectionManager.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 14/06/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import Foundation
import SceneKit


class HintSystem {
    
    var toolSelectedA : Tool?
    var toolSelectedB : Tool?
    
    private var experiment : Experiment
    private var selectionRing : SCNNode
    
    init(_ experiment : Experiment){
        self.experiment = experiment
        
        selectionRing  = ScnModelLoader.loadModel("selector_ring")!
        selectionRing.isHidden = true
        
        experiment.sceneRoot.addChildNode(selectionRing)
    }
    
    func highLightTool(_ tool : Tool) {
        let bounds = tool.node.geometry!.boundingBox
        let toolScale = tool.node.scale
        let toolDimensions = bounds.max - bounds.min
        
        selectionRing.isHidden = false
        selectionRing.position = tool.node.position
        selectionRing.scale = SCNVector3(1,1,1)
        
        if toolDimensions.x > toolDimensions.z{
            selectionRing.scale = selectionRing.scale * (toolDimensions.x * toolScale.x + 0.03)
        }
        else{
            selectionRing.scale = selectionRing.scale * (toolDimensions.z * toolScale.z + 0.03)
        }
    }
}
