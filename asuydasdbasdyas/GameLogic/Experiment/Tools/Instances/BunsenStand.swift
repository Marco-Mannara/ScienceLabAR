//
//  BunsenStand.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 16/06/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import Foundation
import SceneKit

class BunsenStand : Tool, Stackable{
    
    var toolPlacedOnTop : Bool = false
    
    override func isCompatible(_ otherTool: Tool) -> Bool {
        if type(of: otherTool) == Bunsen.self{
            return true
        }
        else if type(of: otherTool) == Becker.self{
            return true
        }
        return false
    }
    
    override func useWith(_ otherTool: Tool) {
        if type(of: otherTool) == Bunsen.self{
            otherTool.place(getAnchorPosition(.down))
            otherTool.state?.enter(StatePositioned.self)
        }
        else if type(of: otherTool) == Becker.self{
            otherTool.place(getAnchorPosition(.up))
            otherTool.state?.enter(StatePositioned.self)
            toolPlacedOnTop = true
        }
    }
    
    func toolAddedToStack(_ otherTool: Tool) {
    }
}
