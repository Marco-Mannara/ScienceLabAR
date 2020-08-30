//
//  StateInspect.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 01/07/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import Foundation
import GameplayKit
import SceneKit

class StateInspect : ToolState{
    
    private var previousState : GKState?
    private var infoNode : SCNNode?
    
    override func onTap() {
        if let previousState = previousState{
            stateMachine?.enter(type(of: previousState))
        }
        else{
            stateMachine?.enter(StateIdle.self)
        }
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        if stateClass == StatePickedUp.self{
            return true
        }
        else if stateClass == StateMenuActive.self{
            return true
        }
        else if stateClass == StateDisabled.self{
            return true
        }
        return false
    }
    
    override func didEnter(from previousState: GKState?) {
        let toolState = stateMachine as! ToolStateMachine
        let tool = toolState.tool
        
        let info = tool.getInfo()
        var string = ""
        
        for i in 0 ... info.count - 1{
            string += info[i] + "\n"
        }
        
        let textGeometry = SCNText(string: string, extrusionDepth: 0.1)
        textGeometry.font = UIFont(name: "Helvetica", size: 1)
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.white
        material.lightingModel = .constant
        textGeometry.materials = [material]
        let infoNode = SCNNode(geometry: textGeometry)
        
        infoNode.scale = SCNVector3(0.03 * 1.0 / tool.node.scale.x,0.03 * 1.0 / tool.node.scale.y, 0.03 * 1.0 / tool.node.scale.z)
        infoNode.position = tool.getAnchor(.upRight)
        infoNode.constraints = [SCNBillboardConstraint()]
        tool.node.addChildNode(infoNode)
        self.infoNode = infoNode
        
        self.previousState = previousState
    }
    
    override func willExit(to nextState: GKState) {
        super.willExit(to: nextState)
        infoNode?.removeFromParentNode()
    }
}
