//
//  Player.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 13/04/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
// 
/*
 import UIKit
import GameplayKit

class Player: GKEntity, EntityCollisionProtocol {

    var maxHealth : Int
    var health : Int = 0

    var mainNode : SCNNode
    var agent : GKAgent2D
    
    var mesh : MeshRendererComponent?
    var physics : PhysicsComponent?
    var movement : PlayerMovementComponent?
    
    init(_ maxHealth: Int )
    {
        self.maxHealth = maxHealth
        self.health = maxHealth
        self.mainNode = SCNNode()
        self.agent = GKAgent2D()
        
        super.init()
        
        self.mesh = MeshRendererComponent.Box(0.01,UIColor.red)
        self.physics = PhysicsComponent(SCNPhysicsShape(geometry: self.mesh!.node.geometry!), false)
        self.movement = PlayerMovementComponent(self.physics!, self.mesh!)
        
        self.addComponent(mesh!)
        self.addComponent(physics!)
        self.addComponent(movement!)
        
        self.physics?.body.isAffectedByGravity = true
        self.physics?.body.angularVelocityFactor = SCNVector3Zero
        //self.physics?.body.continuousCollisionDetectionThreshold = 0.1
    
        self.mainNode = physics!.node
        self.mainNode.addChildNode(mesh!.node)
        
        self.mainNode.entity = self
    }
    
    required init?(coder: NSCoder){
       fatalError("init(coder:) has not been implemented")
    }
    
    override func update(deltaTime seconds: TimeInterval){
        agent.position = simd_float2(mainNode.presentation.position.x, mainNode.presentation.position.z)
        movement!.update(deltaTime: seconds)
    }
    
    func collisionBegin(_ contact: SCNPhysicsContact, _ otherNode : SCNNode)
    {
        
    }
    
    func collisionUpdate(_ contact: SCNPhysicsContact, _ otherNode : SCNNode)
    {
        
    }
    
    func collisionEnd(_ contact: SCNPhysicsContact, _ otherNode: SCNNode)
    {

    }
    
    func spawn(_ scene: SCNScene, _ position: simd_float3){
        agent.position = simd_float2(position.x,position.z)
        mainNode.simdPosition = position
        scene.rootNode.addChildNode(mainNode)
    }
}
*/
