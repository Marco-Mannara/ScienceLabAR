//
//  DisabledState.swift
//  ScienceLabAR
//
//  Created by Marco Mannara on 29/08/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import Foundation
import SceneKit

class StateDisabled : ToolState{
    override func onTap() {
        let toolState = stateMachine as! ToolStateMachine
        toolState.experiment.selection?.selectTool(toolState.tool)
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        if stateClass == StateInspect.self {
            return true
        }
        return false
    }
}
