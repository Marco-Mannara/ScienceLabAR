//
//  Becco.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 28/06/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import Foundation
import SceneKit


class Becco : Container{
    
    override func isCompatible(_ otherTool: Tool) -> Bool {
        if type(of: otherTool) == Container.self{
           return true
        }
        return false
    }
    
    override func useWith(_ otherTool: Tool) {
        if let container = otherTool as? Container{
            if let substance = container.draw(3){
                fill(with: substance,volume: 3)
            }
        }
    }
    
    override func fill(with substance: Substance, volume: Int) {
        super.fill(with: substance,volume: volume)
    }
    
    override func draw(_ volumeInMilliliters : Int) -> Substance? {
        if !contents.isEmpty{
            if contentsVolumeInMilliliters >= volumeInMilliliters{
                if contentsVolumeInMilliliters == volumeInMilliliters{
                    contentsNode.isHidden = true
                    contents.removeAll()
                }
                return contents.first!.key
            }
        }
        return nil
    }
}
