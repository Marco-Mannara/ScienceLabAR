//
//  ToolStateMachine+StateIdle.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 01/07/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import Foundation
import GameplayKit

class StateIdle : ToolState{
    
    override func onTap() {
        stateMachine?.enter(StatePickedUp.self)
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        if stateClass == StateMenuIdle.self{
            return true
        }
        else if stateClass == StatePickedUp.self{
            return true
        }
        else if stateClass == StateDisabled.self{
            return true
        }
        return false
    }
    
    override func didEnter(from previousState: GKState?) {
        let toolState = stateMachine as! ToolStateMachine
        
        toolState.tool.reset()
    }
    
    override func willExit(to nextState: GKState) {
        super.willExit(to: nextState)
    }
}
