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
        
        let textGeometry = SCNText(string: string, extrusionDepth: 0.05)
        textGeometry.font = UIFont(name: "Helvetica", size: 2)
        textGeometry.materials.first?.diffuse.contents = UIColor.white
        let infoNode = SCNNode(geometry: textGeometry)
        
        infoNode.scale = SCNVector3(0.1,0.1,0.1)
        infoNode.position = tool.getAnchor(.upRight)
        tool.node.addChildNode(infoNode)
        self.infoNode = infoNode
        
        self.previousState = previousState
        //print("inspect mode")
        /*let mainCameraNode = GameManager.getInstance().sceneManager.mainCameraNode!
         
         node.runAction(SCNAction.move(to: mainCameraNode.position + mainCameraNode.worldFront * 0.3, duration: 0.5))
         mainCameraNode.addChildNode(node)*/
    }
    
    override func willExit(to nextState: GKState) {
        super.willExit(to: nextState)
        /*
         let toolState = stateMachine as! ToolStateMachine
         let node = toolState.tool.node
         
         toolState.experiment.sceneRoot!.addChildNode(node)
         node.runAction(SCNAction.move(to: lastPosition!, duration: 0.5))
         */
        infoNode?.removeFromParentNode()
    }
}
