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
        
        let states : [GKState] = [StateUnspawned(),StateIdle(), StatePositioned(), StatePickedUp(),StateMenu()]
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
        stateMachine?.enter(StateMenu.self)
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        if stateClass == StateMenu.self{
            return true
        }
        return false
    }
    
    override func didEnter(from previousState: GKState?) {
        let toolState = stateMachine as! ToolStateMachine
        
        toolState.tool.resetPosition()
        toolState.experiment.hint?.disableHighlight(toolState.tool)
        toolState.experiment.toolMenu?.hide()
    }
    
    override func willExit(to nextState: GKState) {
        super.willExit(to: nextState)
    }
}

class StateMenu : ToolState{
    
    override func onTap() {
        
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        if stateClass == StatePickedUp.self{
            return true
        }
        else if stateClass == StateIdle.self{
            return true
        }
        return false
    }
    
    override func willExit(to nextState: GKState) {
        super.willExit(to: nextState)
    }
    
    override func didEnter(from previousState: GKState?) {
        let toolState = stateMachine as! ToolStateMachine
        
        toolState.experiment.hint?.highLightTool(toolState.tool)
        toolState.experiment.toolMenu?.display(toolState.tool)
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
    }
    
    override func didEnter(from previousState: GKState?) {
        let toolState = stateMachine as! ToolStateMachine
        
        toolState.tool.place(toolState.tool.node.position + SCNVector3(0,0.1,0))
        if !toolState.experiment.selection!.selectTool(toolState.tool){
            stateMachine?.enter(StateIdle.self)
        }
    }
}

class StatePositioned : ToolState{
    
    override func onTap() {
        
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
    
    override func didEnter(from previousState: GKState?) {
        let toolState = stateMachine as! ToolStateMachine
        
        toolState.experiment.hint?.disableHighlight(toolState.tool)
        toolState.tool.place(toolState.experiment.workPosition!.node.position)
    }
}




