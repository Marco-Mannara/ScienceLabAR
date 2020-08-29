//
//  IdleMenuState.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 01/07/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import Foundation
import GameplayKit

class StateMenuIdle : ToolState{
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        if stateClass == StatePickedUp.self{
            return true
        }
        else if stateClass == StateIdle.self{
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
    
    override func didEnter(from previousState: GKState?) {
        let toolState = stateMachine as! ToolStateMachine
        
        toolState.experiment.hint?.highLightTool(toolState.tool)
        toolState.experiment.menuManager?.idleMenu.display(toolState.tool)
    }
    
    override func willExit(to nextState: GKState) {
        super.willExit(to: nextState)
        let toolState = stateMachine as! ToolStateMachine
        toolState.experiment.menuManager?.idleMenu.hide()
        toolState.experiment.hint?.disableHighlight(toolState.tool)
    }
}
