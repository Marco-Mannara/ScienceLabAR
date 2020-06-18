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

class Tool : GKEntity, EntityHitProtocol{

    var node : SCNNode
    var displayName : String
    var restPoint : SCNNode?
    
    var state : ToolStateMachine?

    
    init(_ node : SCNNode, _ displayName : String){
        self.node = node
        self.displayName = displayName
        
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
            place(position)
        }
    }
    
    func spawn(_ experiment : Experiment){
        experiment.sceneRoot.addChildNode(node)
        
        state = ToolStateMachine(experiment, self)
        state?.enter(StateIdle.self)
        state?.debug = true
    }
    
    func place(_ position: SCNVector3){
        let toolBounds = node.boundingSphere
        node.position =  position + SCNVector3(0,toolBounds.radius * node.scale.y / 2.0,0)
    }
    
    func getAnchorPosition(_ type: AnchorType) -> SCNVector3{
        let toolBounds = node.boundingSphere
        
        switch type {
        case .upRight:
            return node.position + SCNVector3(toolBounds.radius * node.scale.x,toolBounds.radius * node.scale.y, 0)
        case .upLeft:
            return node.position + SCNVector3(-toolBounds.radius * node.scale.x,toolBounds.radius * node.scale.y, 0)
        case .back:
            return node.position + SCNVector3(0,0,-toolBounds.radius * node.scale.z)
        case .front:
            return node.position + SCNVector3(0,0,toolBounds.radius * node.scale.z)
        case .left:
            return node.position + SCNVector3(-toolBounds.radius * node.scale.x,0,0)
        case .right:
            return node.position + SCNVector3(toolBounds.radius * node.scale.x,0,0)
        case .up:
            return node.position + SCNVector3(0,toolBounds.radius * node.scale.y, 0)
        case .down:
            return node.position + SCNVector3(0,-toolBounds.radius * node.scale.y,0)
        }
    }
    
    func hit(_ hitResult: SCNHitTestResult) {
    }
    
    static func instantiate(_ node : SCNNode, _ name : String) -> Tool?{
        if name == "bunsen_stand"{
            return BunsenStand(node,name)
        }
        return nil
    }
    
}

enum AnchorType{
    case up
    case down
    case left
    case right
    case front
    case back
    case upRight
    case upLeft
}
