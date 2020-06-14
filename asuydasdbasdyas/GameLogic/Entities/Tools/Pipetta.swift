//
//  Pipetta.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 13/06/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import Foundation
import SceneKit

class Pipetta : LiquidContainer, EntityHitProtocol, EntityCollisionProtocol{
   
    
    
    override func isCompatible(_ otherTool: Tool) -> Bool {
        if type(of: otherTool) == Becker.self {
            return true
        }
        
        return false
    }
    
    override func useWith(_ otherTool: Tool) {
        if type(of: otherTool) == Becker.self{
            
        }
    }
    
    func hit(_ hitResult: SCNHitTestResult) {
        print("hit pipetta")
    }
    
    func collisionBegin(_ contact: SCNPhysicsContact, _ otherNode: SCNNode) {
        
    }
    
    func collisionUpdate(_ contact: SCNPhysicsContact, _ otherNode: SCNNode) {
        
    }
    
    func collisionEnd(_ contact: SCNPhysicsContact, _ otherNode: SCNNode) {
        
    }
}
