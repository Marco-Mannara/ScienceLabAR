//
//  DisabledState.swift
//  ScienceLabAR
//
//  Created by Marco Mannara on 29/08/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import Foundation
import SceneKit
import GameplayKit

class StateDisabled : ToolState{
    private var selected = false
    override func onTap() {
        let toolState = stateMachine as! ToolStateMachine
        toolState.experiment.selection?.selectTool(toolState.tool)
        selected = !selected
        if selected{
            toolState.experiment.hint?.highLightTool(toolState.tool)
        }
        else{
            toolState.experiment.hint?.disableHighlight(toolState.tool)
        }
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        if stateClass == StateInspect.self {
            return true
        }
        return false
    }
    
    override func didEnter(from previousState: GKState?) {
        let toolState = stateMachine as! ToolStateMachine
        
        toolState.experiment.hint?.disableHighlight(toolState.tool)
        toolState.experiment.hint?.disableArrow(toolState.tool.node)
    }
}
