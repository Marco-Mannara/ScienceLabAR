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
    private var pointedElements : [SCNNode : SCNNode]
    
    private var experiment : Experiment
    
    private var highlightRingPool : NodePool
    private var hintArrowPool : NodePool
    
    init(_ experiment : Experiment){
        self.experiment = experiment
        self.highlightedElements = [:]
        self.pointedElements = [:]
        
        let highlightRing  = NodeLoader.loadModel("selector_ring")!
        let hintArrow = NodeLoader.loadModel("interaction_symbols/arrow_symbol","arrow")!
        
        highlightRingPool  = NodePool(highlightRing, experiment.sceneRoot!, 3)
        hintArrowPool = NodePool(hintArrow, experiment.sceneRoot!, 3)
    }
    
    func highLightTool(_ tool : Tool) {
        let toolNode = tool.node
        highlightNode(toolNode)
    }
    
    func highlightNode(_ node : SCNNode){
        let bounds = node.geometry!.boundingBox
        let toolScale = node.scale
        let toolDimensions = bounds.max - bounds.min
        
        if let highlightRing = highlightRingPool.request(){
            highlightedElements[node] = highlightRing
            
            highlightRing.position = node.position
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
        disableHighlight(tool.node)
    }
    
    func disableHighlight(_ node: SCNNode){
        if let ring = highlightedElements[node]{
            highlightRingPool.release(ring)
            highlightedElements.removeValue(forKey: node)
        }
        else{
            print("THERE IS NO HIGHLIGHT RING TO DISABLE")
        }
    }
    
    func enableArrow(_ node: SCNNode){
        if let arrow = hintArrowPool.request(){
            arrow.position = node.position + SCNVector3(0,0.12,0)
            arrow.look(at: node.position)
            pointedElements[node] = arrow
        }
        else{
            print("NO AVAIABLE ARROWS IN POOL")
        }
    }
    
    func disableArrow(_ node : SCNNode){
        if let arrow = highlightedElements[node]{
            hintArrowPool.release(arrow)
            pointedElements.removeValue(forKey: node)
        }
        else{
            print("THERE IS NO ARROW TO DISABLE")
        }
    }
    
    func disableAllArrows(){
        hintArrowPool.releaseAll()
    }
    
    func disableAllHighlights(){
        highlightRingPool.releaseAll()
    }
}
