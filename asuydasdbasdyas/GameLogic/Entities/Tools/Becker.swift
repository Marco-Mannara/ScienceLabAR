//
//  Becker.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 11/06/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import Foundation
import SceneKit
import SpriteKit

class Becker : LiquidContainer {
    
    
    override init(_ node :SCNNode, _ displayName: String, _ volumeCapacity : Float){
        super.init(node, displayName, volumeCapacity)
        
    }
    
    init(_ node : SCNNode, _ displayName: String, _ volumeCapacity : Float, _ filledWith: Substance){
        super.init(node, displayName, volumeCapacity)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func isCompatible(_ otherTool: Tool) -> Bool {
        //TODO: replace with actual function
        return true
    }
    
    override func useWith(_ otherTool: Tool) {
        if !isCompatible(otherTool) {
            return
        }
    }
}
