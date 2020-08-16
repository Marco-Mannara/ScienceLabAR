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
    var meshNode : SCNNode
    
    var displayName : String
    var restPoint : SCNNode!
    
    var state : ToolStateMachine?
    var interaction : [String : Interaction]?
    
    
    init(_ node : SCNNode, _ displayName : String){
        self.node = node
        self.displayName = displayName
        self.meshNode = node.childNode(withName: "mesh", recursively: false)!
        
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
    
    func reset(){
        if let position = restPoint?.position{
            place(position)
        }
    }
    
    func spawn(_ experiment : Experiment){
        experiment.sceneRoot!.addChildNode(node)
        
        state = ToolStateMachine(experiment, self)
        state?.enter(StateIdle.self)
        state?.debug = true
    }
    
    func place(_ position: SCNVector3){
        let toolBounds = node.boundingSphere
        node.position =  position + SCNVector3(0,toolBounds.radius * node.scale.y / 2.0,0)
    }
    
    func getPositionRelativeToAnchor(_ position : SCNVector3, _ type : AnchorType) -> SCNVector3{
        let bounds = node.boundingBox.max - node.boundingBox.min
        switch type {
        case .back:
            return position + SCNVector3(0,0,bounds.z * node.scale.z / 2.0)
        case .front:
            return position + SCNVector3(0,0,-bounds.z * node.scale.z / 2.0)
        case .up:
            return position + SCNVector3(0,bounds.y * node.scale.y / 2.0,0)
        case .down:
            return position + SCNVector3(0,-bounds.y * node.scale.y / 2.0,0)
        case .left:
            return position + SCNVector3(-bounds.x * node.scale.x / 2.0,0,0)
        case .right:
            return position + SCNVector3(bounds.x * node.scale.x / 2.0,0,0)
        case .upRight:
            break
        case .upLeft:
            break
        }
        return SCNVector3.zero
    }
    
    func placeRelativeToAnchor(_ position: SCNVector3,_ type: AnchorType){
        let bounds = node.boundingBox.max - node.boundingBox.min
        switch type {
        case .back:
            node.position = position + SCNVector3(0,0,bounds.z * node.scale.z / 2.0)
            break
        case .front:
            node.position = position + SCNVector3(0,0,-bounds.z * node.scale.z / 2.0)
            break
        case .up:
            node.position = position + SCNVector3(0,bounds.y * node.scale.y / 2.0,0)
            break
        case .down:
            node.position = position + SCNVector3(0,-bounds.y * node.scale.y / 2.0,0)
            break
        case .left:
            node.position = position + SCNVector3(-bounds.x * node.scale.x / 2.0,0,0)
            break
        case .right:
            node.position = position + SCNVector3(bounds.x * node.scale.x / 2.0,0,0)
            break
        case .upRight:
            break
        case .upLeft:
            break
        }
    }
    
    func getAnchor(_ type: AnchorType) -> SCNVector3{
        let toolBounds = node.boundingBox.max - node.boundingBox.min
        
        switch type {
        case .upRight:
            return node.position + SCNVector3(toolBounds.x * node.scale.x/2,toolBounds.y * node.scale.y/2, 0)
        case .upLeft:
            return node.position + SCNVector3(-toolBounds.x * node.scale.x/2,toolBounds.y * node.scale.y/2, 0)
        case .back:
            return node.position + SCNVector3(0,0,-toolBounds.z * node.scale.z/2)
        case .front:
            return node.position + SCNVector3(0,0,toolBounds.z * node.scale.z/2)
        case .left:
            return node.position + SCNVector3(-toolBounds.x * node.scale.x/2,0,0)
        case .right:
            return node.position + SCNVector3(toolBounds.x * node.scale.x/2,0,0)
        case .up:
            return node.position + SCNVector3(0,toolBounds.y * node.scale.y/2, 0)
        case .down:
            return node.position + SCNVector3(0,-toolBounds.y * node.scale.y/2,0)
        }
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
