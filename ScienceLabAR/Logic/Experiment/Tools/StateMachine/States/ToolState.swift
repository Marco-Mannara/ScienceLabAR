//
//  ToolState.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 01/07/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import Foundation
import GameplayKit


class ToolState : GKState{
    func onTap(){}

    override func willExit(to nextState: GKState) {
        if (stateMachine as! ToolStateMachine).debug{
            let string = String(format: "Transitioning from %@ to %@ (%@)", String(describing: type(of: self)), String(describing: type(of: nextState)), (stateMachine as! ToolStateMachine).tool.displayName)
            print(string)
        }
    }
}
