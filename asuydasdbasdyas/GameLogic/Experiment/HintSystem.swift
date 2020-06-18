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
    
    private var highlightedElements : [SCNNode : SCNNode]
    
    private var experiment : Experiment
    
    private var highlightRingPool : NodePool
    private var hintArrowPool : NodePool
    
    init(_ experiment : Experiment){
        self.experiment = experiment
        self.highlightedElements = [:]
        
        let highlightRing  = ScnModelLoader.loadModel("selector_ring")!
        let hintArrow = ScnModelLoader.loadModel("interaction_symbol/arrow_symbol","arrow")!
        
        highlightRingPool  = NodePool(highlightRing, experiment.sceneRoot, 3)
        hintArrowPool = NodePool(hintArrow, experiment.sceneRoot, 3)
    }
    
    func highLightTool(_ tool : Tool) {
        
        let bounds = tool.node.geometry!.boundingBox
        let toolScale = tool.node.scale
        let toolDimensions = bounds.max - bounds.min
        
        if let highlightRing = highlightRingPool.request(){
            
            highlightedElements[tool.node] = highlightRing
            
            highlightRing.position = tool.node.position
            highlightRing.scale = SCNVector3(1,1,1)
            
            if toolDimensions.x > toolDimensions.z{
                highlightRing.scale = highlightRing.scale * (toolDimensions.x * toolScale.x + 0.03)
            }
            else{
                highlightRing.scale = highlightRing.scale * (toolDimensions.z * toolScale.z + 0.03)
            }
        }
    }
    
    func disableHighlight(_ tool: Tool){
        highlightedElements.removeValue(forKey: tool.node)
    }
}
