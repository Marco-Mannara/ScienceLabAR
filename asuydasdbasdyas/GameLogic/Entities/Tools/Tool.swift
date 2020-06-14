//
//  Tool.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 11/06/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import Foundation
import GameplayKit
import SceneKit
import SpriteKit

class Tool : GKEntity{

    var node : SCNNode
    var displayName : String
    var restPoint : SCNNode?
    
    var isEnabled : Bool = true
    var isSpawned : Bool = false
    
    var isSelected : Bool {
        didSet{
            if !isSelected{
                node.setHighlighted(false)
            }
            else{
                node.setHighlighted()
            }
        }
    }
    
    
    init(_ node : SCNNode, _ displayName : String){
        self.node = node
        self.displayName = displayName
        self.isSelected = false
        super.init()
        node.entity = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func isCompatible(_ otherTool: Tool) -> Bool{
        return true
    }
    
    func useWith(_ otherTool: Tool)
    {
        
    }
    
    func resetPosition(){
        if let position = restPoint?.position{
            node.position = position
        }
    }
    
    func spawn(_ sceneRoot : SCNNode){
        sceneRoot.addChildNode(node)
        isSpawned = true
    }
    /*
    func collisionBegin(_ contact: SCNPhysicsContact, _ otherNode: SCNNode) {
        
    }
    
    func collisionUpdate(_ contact: SCNPhysicsContact, _ otherNode: SCNNode) {
        
    }
    
    func collisionEnd(_ contact: SCNPhysicsContact, _ otherNode: SCNNode) {
        
    }
    
    func hit(_ hitResult: SCNHitTestResult) {
    }
     */
}
