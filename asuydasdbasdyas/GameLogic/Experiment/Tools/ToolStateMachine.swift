//
//  SelectionStateMachine.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 17/06/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import Foundation
import GameplayKit
import SceneKit

class ToolStateMachine : GKStateMachine{
    var tool : Tool
    var debug : Bool = false
    var experiment : Experiment
    
    init(_ experiment : Experiment, _ tool: Tool) {
        self.tool = tool
        self.experiment = experiment
        
        let states : [GKState] = [StateUnspawned(),StateIdle(), StatePositioned(), StatePickedUp(),StateMenuIdle(), StateMenuActive()]
        super.init(states: states)
    }
}

class ToolState : GKState{
    
    func onTap(){}
    
    override func willExit(to nextState: GKState) {
        if (stateMachine as! ToolStateMachine).debug{
            let string = String(format: "Transitioning from %@ to %@ (%@)", String(describing: type(of: self)), String(describing: type(of: nextState)), (stateMachine as! ToolStateMachine).tool.displayName)
            print(string)
        }
    }
}

class StateUnspawned : ToolState{
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        if stateClass == StateIdle.self{
            return true
        }
        return false
    }
    override func willExit(to nextState: GKState) {
        super.willExit(to: nextState)
    }
}

class StateIdle : ToolState{
    
    override func onTap() {
        stateMachine?.enter(StateMenuIdle.self)
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        if stateClass == StateMenuIdle.self{
            return true
        }
        return false
    }
    
    override func didEnter(from previousState: GKState?) {
        let toolState = stateMachine as! ToolStateMachine
        
        toolState.tool.resetPosition()
        toolState.experiment.hint?.disableHighlight(toolState.tool)
    }
    
    override func willExit(to nextState: GKState) {
        super.willExit(to: nextState)
    }
}

class StateMenuIdle : ToolState{
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        if stateClass == StatePickedUp.self{
            return true
        }
        else if stateClass == StateIdle.self{
            return true
        }
        return false
    }
    
    override func didEnter(from previousState: GKState?) {
        let toolState = stateMachine as! ToolStateMachine
        
        toolState.experiment.hint?.highLightTool(toolState.tool)
        toolState.experiment.menuManager?.idleMenu.display(toolState.tool)
    }
    
    override func willExit(to nextState: GKState) {
        super.willExit(to: nextState)
        let toolState = stateMachine as! ToolStateMachine
        toolState.experiment.menuManager?.idleMenu.hide()
    }
}

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
        return false
    }
    
    override func willExit(to nextState: GKState) {
        super.willExit(to: nextState)
        let toolState = stateMachine as! ToolStateMachine
        
        toolState.experiment.selection?.clearSelection()
        toolState.experiment.hint?.disableAllArrows()
        toolState.experiment.hint?.disableAllHighlights()
    }
    
    override func didEnter(from previousState: GKState?) {
        let toolState = stateMachine as! ToolStateMachine
        let hint = toolState.experiment.hint!
        
        toolState.tool.place(toolState.tool.node.position + SCNVector3(0,0.1,0))
        
        hint.highlightNode(toolState.experiment.workPosition!.node)
        
        hint.enableArrow(toolState.experiment.workPosition!.node)
        hint.enableArrow(toolState.tool.node)
        
        if !toolState.experiment.selection!.selectTool(toolState.tool){
            stateMachine?.enter(StateIdle.self)
        }
    }
}

class StatePositioned : ToolState{
    
    var  combinedWith : Tool?
    
    override func onTap() {
        let toolState = stateMachine as! ToolStateMachine
        
        if let selTool = toolState.experiment.selection?.toolSelected{
            if toolState.tool.isCompatible(selTool){
                toolState.tool.useWith(selTool)
                combinedWith = selTool
            }
            else{
                selTool.state?.enter(StateIdle.self)
            }
        }
        else{
            stateMachine?.enter(StateMenuActive.self)
        }
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        if stateClass == StateIdle.self{
            return true
        }
        else if stateClass == StatePositioned.self{
            return true
        }
        else if stateClass == StateMenuActive.self{
            return true
        }
        return false
    }
    
    override func didEnter(from previousState: GKState?) {
        let toolState = stateMachine as! ToolStateMachine
        
        toolState.experiment.workPosition?.place(toolState.tool)
    }
}

class StateMenuActive : ToolState{
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        if stateClass == StatePositioned.self{
            return true
        }
        else if stateClass == StateIdle.self{
            return true
        }
        return false
    }
    
    override func didEnter(from previousState: GKState?) {
        let toolState = stateMachine as! ToolStateMachine
        
        toolState.experiment.hint?.highLightTool(toolState.tool)
        toolState.experiment.menuManager?.display(toolState.tool)
    }
    
    override func willExit(to nextState: GKState) {
        super.willExit(to: nextState)
        let toolState = stateMachine as! ToolStateMachine
        
        toolState.experiment.menuManager?.hide()
        toolState.experiment.hint?.disableHighlight(toolState.tool)
    }
}



