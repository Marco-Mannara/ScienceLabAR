//
//  PickedUpState.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 01/07/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import Foundation
import GameplayKit

class StatePickedUp : ToolState{
    
    override func onTap() {
        stateMachine?.enter(StateIdle.self)
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        if stateClass == StateIdle.self{
            return true
        }
        else if stateClass == StatePositioned.self{
            return true
        }
        else if stateClass == StateActive.self{
            return true
        }
        else if stateClass == StateInspect.self{
            return true
        }
        else if stateClass == StateDisabled.self{
            return true
        }
        return false
    }
    
    override func willExit(to nextState: GKState) {
        super.willExit(to: nextState)
        let toolState = stateMachine as! ToolStateMachine
        let hint = toolState.experiment.hint!
        hint.disableAllArrows()
        toolState.experiment.selection?.clearSelection()
        
        if nextState is StatePositioned{
            toolState.experiment.workPosition?.place(toolState.tool)
        }
        if !(nextState is StateInspect){
            hint.disableAllHighlights()
        }
    }
    
    override func didEnter(from previousState: GKState?) {
        let toolState = stateMachine as! ToolStateMachine
        let hint = toolState.experiment.hint!
        let workposition = toolState.experiment.workPosition!
        
        toolState.tool.place(toolState.tool.restPoint.position + SCNVector3(0,0.1,0))
        
        hint.highLightTool(toolState.tool)
           hint.enableArrow(toolState.tool.node)
        if workposition.isEmpty(){
            hint.highlightNode(workposition.node)
            hint.enableArrow(toolState.experiment.workPosition!.node)
        }else{
            let compTools = workposition.getCompatibleTools(for: toolState.tool)
            hint.highlightTools(compTools)
            hint.enableArrow(compTools)
        }
        
        if !toolState.experiment.selection!.selectTool(toolState.tool){
            stateMachine?.enter(StateIdle.self)
        }
    }
}
