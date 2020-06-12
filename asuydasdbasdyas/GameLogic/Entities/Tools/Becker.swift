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
    
    init(_ node: SCNNode, _ displayName: String, volumeCapacity : Float){
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
    
    override func hit(_ hitResult: SCNHitTestResult) {
        node.geometry?.materials.first?.diffuse.contents = UIColor.yellow
    }
    
    override func collisionBegin(_ contact: SCNPhysicsContact, _ otherNode: SCNNode) {
        
    }
    
    override func collisionUpdate(_ contact: SCNPhysicsContact, _ otherNode: SCNNode) {
        
    }
    
    override func collisionEnd(_ contact: SCNPhysicsContact, _ otherNode: SCNNode) {
        
    }
    
}
