//
//  Player.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 13/04/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import UIKit
import GameplayKit

class Player: GKEntity {
    
    var maxHealth : Int
    var health : Int = 0
    var speed : Float
    var mass : Float = 20
    
    
    var mainNode : SCNNode
    var agent : GKAgent2D
    
    var mesh : MeshRendererComponent?
    var physics : PhysicsComponent?
    var movement : PlayerMovementComponent?
    
    init(_ maxHealth: Int, _ speed: Float )
    {
        self.maxHealth = maxHealth
        self.health = maxHealth
        self.speed = speed
        self.mainNode = SCNNode()
        self.agent = GKAgent2D()
        
        super.init()
        
        self.mesh = MeshRendererComponent.Box(0.01,UIColor.red)
        self.physics = PhysicsComponent(SCNPhysicsShape(geometry: self.mesh!.node.geometry!), false)
        self.movement = PlayerMovementComponent(self.physics!, self.mesh!)
        
        self.addComponent(mesh!)
        self.addComponent(physics!)
        self.addComponent(movement!)
        
        self.physics?.body.mass = CGFloat(self.mass)
        self.physics?.body.isAffectedByGravity = true
        self.physics?.body.angularVelocityFactor = SCNVector3Zero
        
        self.mainNode = physics!.node
        self.mainNode.addChildNode(mesh!.node)
    }
    
    override func update(deltaTime seconds: TimeInterval)
    {
        agent.position = simd_float2(mainNode.presentation.position.x, mainNode.presentation.position.z)
        movement!.update(deltaTime: seconds)
    }
    
    func spawn(_ scene: SCNScene, _ position: simd_float3){
        agent.position = simd_float2(position.x,position.z)
        mainNode.simdPosition = position
        scene.rootNode.addChildNode(mainNode)
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
}
