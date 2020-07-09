//
//  PositionedState.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 01/07/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import Foundation
import GameplayKit

class StatePositioned : ToolState{
    
    override func onTap() {
        let toolState = stateMachine as! ToolStateMachine
        
        if let selTool = toolState.experiment.selection?.selectedTool{
            if toolState.tool.isCompatible(selTool){
                toolState.tool.useWith(selTool)
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
        else if stateClass == StateActive.self{
            return true
        }
        return false
    }
}
