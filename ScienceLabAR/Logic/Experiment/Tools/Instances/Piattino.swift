//
//  Piattino.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 26/06/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import Foundation
import SceneKit

class Piattino : Container, Stackable{
    
    override func isCompatible(_ otherTool: Tool) -> Bool {
        if type(of: otherTool) == Becco.self{
            return true
        }
        return false
    }
    
    override func useWith(_ otherTool: Tool) {
        if let becco = otherTool as? Becco{
            becco.useWith(self)
        }
    }
    
    override func fill(with substance: Substance, volume: Float) {
        super.fill(with: substance, volume: volume)
    }
    
    override func draw(_ volumeInMilliliters : Float) -> Substance? {
        return super.draw(volumeInMilliliters)
    }
    
    func toolAddedToStack(_ otherTool: Tool) {
    }
}
