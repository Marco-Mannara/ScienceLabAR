//
//  Pipetta.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 13/06/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import Foundation
import SceneKit

class Pipetta : Container{
   
    
    override func isCompatible(_ otherTool: Tool) -> Bool {
        if type(of: otherTool) == Becker.self {
            return true
        }
        
        return false
    }
    
    override func useWith(_ otherTool: Tool) {
        super.useWith(otherTool)
        if type(of: otherTool) == Becker.self{
            
        }
    }
}
