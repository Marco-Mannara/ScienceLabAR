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
    
    
    override func onTap() {
        stateMachine?.enter(StatePickedUp.self)
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        if stateClass == StatePickedUp.self{
            return true
        }
        else if stateClass == StateMenuActive.self{
            return true
        }
        return false
    }
    
    override func didEnter(from previousState: GKState?) {
        let toolState = stateMachine as! ToolStateMachine
        let node = toolState.tool.node
        let mainCameraNode = GameManager.getInstance().sceneManager.mainCameraNode!
        
        node.runAction(SCNAction.move(to: mainCameraNode.position + mainCameraNode.worldFront * 0.3, duration: 0.5))
        mainCameraNode.addChildNode(node)
    }
    
    override func willExit(to nextState: GKState) {
        super.willExit(to: nextState)
        
        let toolState = stateMachine as! ToolStateMachine
        let node = toolState.tool.node
        
        toolState.experiment.sceneRoot!.addChildNode(node)
        //node.runAction(SCNAction.move(to: lastPosition!, duration: 0.5))
    }
}
