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

class Becker : LiquidContainer, EntityHitProtocol, EntityCollisionProtocol {
    
    override func isCompatible(_ otherTool: Tool) -> Bool {
        //TODO: replace with actual function
        return true
    }
    
    override func useWith(_ otherTool: Tool) {
        if !isCompatible(otherTool) {
            return
        }
    }
    
    func hit(_ hitResult: SCNHitTestResult) {
        node.geometry?.materials.first?.diffuse.contents = UIColor.yellow
        print("hit becker")
    }
    
    func collisionBegin(_ contact: SCNPhysicsContact, _ otherNode: SCNNode) {
        
    }
    
    func collisionUpdate(_ contact: SCNPhysicsContact, _ otherNode: SCNNode) {
        
    }
    
    func collisionEnd(_ contact: SCNPhysicsContact, _ otherNode: SCNNode) {
        
    }
    
}
