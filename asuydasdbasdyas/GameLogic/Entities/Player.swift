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
    var mesh : MeshRendererComponent?
    var physics : PhysicsComponent?
    var movement : PlayerMovementComponent?
    
    init(_ maxHealth: Int, _ speed: Float )
    {
        self.maxHealth = maxHealth
        self.health = maxHealth
        self.speed = speed
        self.mainNode = SCNNode()
        
        super.init()
        
        self.mesh = MeshRendererComponent(self.createMesh())
        self.physics = PhysicsComponent(self.createPhysics(mesh!.node.geometry!), false)
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
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func createMesh() -> SCNGeometry
    {
        let dimension = CGFloat(0.1)
        let geom = SCNBox(width: dimension, height: dimension, length: dimension, chamferRadius: dimension / 10)
        geom.materials.first?.diffuse.contents = UIColor.red
        return geom
    }
    
    func createPhysics (_ physicsShape : SCNGeometry) -> SCNPhysicsShape
    {
        return SCNPhysicsShape(geometry: physicsShape)
    }
}
