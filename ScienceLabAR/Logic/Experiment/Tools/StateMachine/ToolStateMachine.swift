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
    var experiment : Experiment
    
    init(_ experiment : Experiment, _ tool: Tool) {
        self.tool = tool
        self.experiment = experiment
        
        let states : [GKState] = [StateIdle(), StatePositioned(), StatePickedUp(),StateMenuIdle(), StateMenuActive(), StateActive(),StateInspect()]
        super.init(states: states)
    }
}
