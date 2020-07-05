//
//  ActiveState.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 02/07/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import Foundation
import GameplayKit

class StateActive : ToolState{
    override func onTap() {}
    
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
        toolState.experiment.hint?.disableArrow(toolState.tool.node)
        toolState.experiment.hint?.disableHighlight(toolState.tool)
    }
}
