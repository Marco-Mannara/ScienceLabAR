//
//  StateInspect.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 01/07/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import Foundation
import GameplayKit

class StateInspect : ToolState{
    
    private var lastPosition : SCNVector3?
    
    override func onTap() {
        
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        if stateClass == StateMenuIdle.self{
            return true
        }
        else if stateClass == StateMenuActive.self{
            return true
        }
        return false
    }
    
    override func didEnter(from previousState: GKState?) {
        
    }
    
    override func willExit(to nextState: GKState) {
        super.willExit(to: nextState)
        let toolState = stateMachine as! ToolStateMachine
    }
}
