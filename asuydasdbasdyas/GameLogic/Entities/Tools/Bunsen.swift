//
//  Bunsen.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 16/06/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import Foundation
import SceneKit

class Bunsen : Heater{ 
    
    override func isCompatible(_ otherTool: Tool) -> Bool {
        if type(of: otherTool) == BunsenStand.self {
            return true
        }
        return false
    }
    
    override func useWith(_ otherTool: Tool) {
        super.useWith(otherTool)
  
        if type(of: otherTool) == BunsenStand.self {
            otherTool.state?.enter(StatePositioned.self)
            otherTool.place(getAnchorPosition(.down))
        }
    }
    
    override func toolAddedToStack(_ otherTool: Tool) {
        if let becker = otherTool as? Becker {
            heatedTool = becker
        }
    }
}

