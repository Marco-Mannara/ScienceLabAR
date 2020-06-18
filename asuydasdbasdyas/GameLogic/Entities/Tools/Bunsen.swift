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
        if !isCompatible(otherTool){
            return
        }
        else{
            if type(of: otherTool) == BunsenStand.self {
                otherTool.place(node.position)
            }
        }
    }
}

